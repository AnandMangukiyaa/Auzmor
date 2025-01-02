import 'package:auzmor_assignment/blocs/training/training_bloc.dart';
import 'package:auzmor_assignment/core/constants/constants.dart';
import 'package:auzmor_assignment/core/enums/enums.dart';
import 'package:auzmor_assignment/core/routes/app_routes.dart';
import 'package:auzmor_assignment/core/utils/utils.dart';
import 'package:auzmor_assignment/models/models.dart';
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

  @override
  void initState() {
    _trainingBloc.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.homeAppBar(context, title: "Categories"),
      backgroundColor: Colors.white,
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: BlocBuilder<TrainingBloc,TrainingState>(
          bloc: _trainingBloc,
          builder: (context,state) {
            if(state.status == ResultStatus.success && state.categories != null && state.categories!.isNotEmpty){
              trainings.addAll(state.categories![0].trainings!);
            }
            return state.status == ResultStatus.loading ?Center(
              child: CircularProgressIndicator(),
            ):state.status == ResultStatus.failure ? Center(
              child: PrimaryText(state.message),
            ):state.categories == null ? Center(
              child: PrimaryText("No Categories Found"),
            ):state.categories!.isEmpty ? Center(
              child: PrimaryText("No Categories Found"),
            ):Column(
              children: [
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
                          trainings.clear();
                          trainings.addAll(state.categories![index].trainings!);
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),)),
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
            );

          }
        ),
      )
    );
  }
}

