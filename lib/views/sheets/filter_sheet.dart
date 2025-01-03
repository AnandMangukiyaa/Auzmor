import 'package:auzmor_assignment/core/constants/constants.dart';
import 'package:auzmor_assignment/core/utils/utils.dart';
import 'package:auzmor_assignment/models/models.dart';
import 'package:auzmor_assignment/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
 final Categories category;
  const FilterSheet({Key? key, required this.category}) : super(key: key);
  static Future<Map<String,List<String>>> showSheet(
      BuildContext context, Categories category) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.s16.w),
      ),
      builder: (context) {
        return FilterSheet(category: category,);
      },
    );
  }

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  // Sample filter data
  List<String> options = [
  ];
  List<String> selectedLocations = [
  ];
  List<String> selectedTrainers = [
  ];
  List<String> selectedTrainings = [
  ];

  final List<String>filters = [
    "Location",
    "Training Name",
    "Trainer",
  ];

  int selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    options = widget.category.trainings!.map((e) => e.location!).toList();


  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.6,
      child: Padding(
        padding: EdgeInsets.all(Sizes.s16.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: PrimaryText("Sort & Filters", size: Sizes.s20.sp)),
                SizedBox(width: Sizes.s8.w),
                IconButton(
                  onPressed: () {
                    var map = {
                      "locations": selectedLocations,
                      "trainers": selectedTrainers,
                      "trainings": selectedTrainings,
                    };
                    Navigator.pop(context,map);
                  },
                  icon: Icon(Icons.check),
                ),
                SizedBox(width: Sizes.s8.w),
                IconButton(
                  onPressed: () {
                    Map<String,List<String>> map ={};
                    Navigator.pop(context,map);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade500,),
            SizedBox(height: Sizes.s16.h),
            Expanded(
              child: Row(
                  children: [
                    // Vertical TabBar
                    Expanded(
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(Sizes.s16.w),
                              child: PrimaryText("Sort By", size: Sizes.s16.sp,weight: FontWeight.w900,),
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: filters.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: Sizes.s16.h,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        selectedFilter = index;
                                        if(selectedFilter == 0) {
                                          options = widget.category.trainings!.map((e) => e.location!).toList();
                                        }else if(selectedFilter == 1) {
                                          options = widget.category.trainings!.map((e) => e.name!).toList();
                                        }else if(selectedFilter == 2) {
                                          options = widget.category.trainings!.map((e) => e.trainerName!).toList();
                                        }
                                      });
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        if(selectedFilter == index) Container(width: Sizes.s4.w,height: Sizes.s40.h,color: Colors.red,),
                                        Expanded(
                                          child: Container(
                                            height: Sizes.s40.h,
                                            decoration: selectedFilter == index
                                                ? BoxDecoration(
                                              color: Colors.white,
                                            )
                                                : null,
                                            padding: EdgeInsets.only(left:Sizes.s12.w),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                PrimaryText("${filters[index]}", size: Sizes.s14.sp),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            var location = options[index];
                            return CheckboxListTile(
                              title: Text(location),
                              value: selectedFilter==0?selectedLocations.contains(location):selectedFilter==1?selectedTrainings.contains(location):selectedTrainers.contains(location),
                              onChanged: (bool? value) {
                                if(selectedFilter ==0) {
                                if (selectedLocations.contains(location)) {
                                  selectedLocations.remove(location);
                                } else {
                                  selectedLocations.add(location);
                                }
                              }else if(selectedFilter ==1) {
                                  if (selectedTrainings.contains(location)) {
                                    selectedTrainings.remove(location);
                                  } else {
                                    selectedTrainings.add(location);
                                  }
                                }else if(selectedFilter ==2) {
                                  if (selectedTrainers.contains(location)) {
                                    selectedTrainers.remove(location);
                                  } else {
                                    selectedTrainers.add(location);
                                  }
                                }
                              setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
