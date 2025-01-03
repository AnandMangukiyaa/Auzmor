import 'package:auzmor_assignment/blocs/training/training_bloc.dart';
import 'package:auzmor_assignment/core/constants/constants.dart';
import 'package:auzmor_assignment/core/enums/enums.dart';
import 'package:auzmor_assignment/core/routes/app_routes.dart';
import 'package:auzmor_assignment/core/utils/utils.dart';
import 'package:auzmor_assignment/models/models.dart';
import 'package:auzmor_assignment/views/sheets/filter_sheet.dart';
import 'package:auzmor_assignment/views/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //
  final CarouselController _carouselController = CarouselController();
  final TrainingBloc _trainingBloc = GetIt.I<TrainingBloc>();
  List<Training> trainings = [];
  int selectedIndex = 0;
  List<String> selectedLocations = [];
  List<String> searchTrainingName = [];
  List<String> searchTrainerName = [];

  @override
  void initState() {
    _trainingBloc.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.homeAppBar(context, title: "Trainings"),
      backgroundColor: Colors.white,
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: BlocBuilder<TrainingBloc,TrainingState>(
          bloc: _trainingBloc,
          builder: (context,state) {
            if(state.status == ResultStatus.success && state.categories != null && state.categories!.isNotEmpty && selectedLocations.isEmpty && searchTrainingName.isEmpty && searchTrainerName.isEmpty){
              trainings.addAll(state.categories![selectedIndex].trainings!);
            }
            return state.status == ResultStatus.loading ?Center(
              child: CircularProgressIndicator(),
            ):state.status == ResultStatus.failure ? Center(
              child: PrimaryText(state.message),
            ):state.categories == null ? Center(
              child: PrimaryText("No Categories Found"),
            ):state.categories!.isEmpty ? Center(
              child: PrimaryText("No Categories Found"),
            ):Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Container(
                      color: Colors.red,
                    )),
                    Expanded(
                      flex: 5,
                        child: Container(
                      color: Colors.grey.shade100,
                    )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Sizes.s16.w,top: Sizes.s8.h),
                      child: PrimaryText("Highlights",size: Sizes.s24.sp,color: Colors.white,weight: FontWeight.bold,),
                    ),
                    SizedBox(height: Sizes.s16.h,),
                    SizedBox(
                      height: Sizes.s200.h,
                        child: CarouselSlider(items: state.categories!.map((e) => CategoryCard(e)).toList(), options: CarouselOptions(
                          height: Sizes.s200.h,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            print("Index: $index");
                            setState(() {
                              if(selectedLocations.isEmpty && searchTrainingName.isEmpty && searchTrainerName.isEmpty){
                                trainings.clear();
                                selectedIndex = index;
                                trainings.addAll(state.categories![index].trainings!);
                              }

                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),)),
                    SizedBox(height: Sizes.s16.h,),
                    GestureDetector(
                      onTap: () async{
                        Map<String,List<String>> filters= await FilterSheet.showSheet(context, state.categories![selectedIndex]);
                        if(filters.isNotEmpty){
                          selectedLocations.clear();
                          searchTrainingName.clear();
                          searchTrainerName.clear();
                          selectedLocations = filters["locations"] ?? [];
                          searchTrainingName = filters["trainings"] ?? [];
                          searchTrainerName = filters["trainers"] ?? [];
                          List<Training> filteredTrainings = getFilteredTrainings(selectedLocations, searchTrainingName, searchTrainerName,state.categories![selectedIndex].trainings!);

                          setState(() {
                            trainings.clear();
                            trainings .addAll(filteredTrainings.length == 0 ? state.categories![selectedIndex].trainings! : filteredTrainings);
                          });
                        }else{
                          setState(() {
                            trainings.clear();
                            trainings.addAll(state.categories![selectedIndex].trainings!);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.s4.w),
                            border: Border.all(color: Colors.grey.shade400,width: Sizes.s1.w)
                        ),
                        margin: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                        padding: EdgeInsets.symmetric(horizontal:Sizes.s12.w,vertical: Sizes.s8.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryText("Filter",color: Colors.grey.shade500,size: Sizes.s12.sp,),
                            SizedBox(width: Sizes.s8.w,),
                            Icon(Icons.filter_list,color: Colors.grey.shade500,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Sizes.s16.h,),
                    Expanded(child: Padding(
                      padding: EdgeInsets.all(Sizes.s8.w),
                      child: ListView.builder(
                        itemCount: trainings.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, Routes.detail,arguments: trainings[index]);
                            },
                              child: TrainingCard(trainings[index])
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ],
            );

          }
        ),
      )
    );
  }

  // Filter logic
  List<Training> getFilteredTrainings(List<String> selectedLocations, List<String> searchTrainingName, List<String> searchTrainerName, List<Training> list) {
    return list.where((training) {
      // Filter by location
      for (var location in selectedLocations) {
        if (training.location!.toLowerCase() == location.toLowerCase()) {
          return true;
        }
      }

      // Filter by training name
      for (var name in searchTrainingName) {
        if (training.name!.toLowerCase().contains(name.toLowerCase())) {
          return true;
        }
      }

      // Filter by trainer name
      for (var trainerName in searchTrainerName) {
        if (training.trainerName!.toLowerCase().contains(trainerName.toLowerCase())) {
          return true;
        }
      }

      return false;
    }).toList();
  }
}

