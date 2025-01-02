import 'package:auzmor_assignment/core/constants/constants.dart';
import 'package:auzmor_assignment/core/utils/utils.dart';
import 'package:auzmor_assignment/models/models.dart';
import 'package:auzmor_assignment/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TrainingDetailPage extends StatelessWidget {
  final Training training;

  const TrainingDetailPage({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backAppBar(context, title: "${training.name}"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Sizes.s20.w),
                bottomRight: Radius.circular(Sizes.s20.w),
              ),
              child: ImageView(
                imageUrl:training.imageUrl!,
                height: Sizes.s250.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: Sizes.s20.h),

            // Training Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  PrimaryText(
                    training.name ?? "",
                      size: Sizes.s24.sp,
                      weight: FontWeight.bold,
                  ),
                  SizedBox(height: Sizes.s8.h),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: Sizes.s6.w),
                      PrimaryText(
                        training.location!,
                       color: Colors.grey[600], size: Sizes.s16.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.s16.h),

                  // Description
                  PrimaryText(
                    "Description",
                      size: Sizes.s18.sp,
                      weight: FontWeight.bold,
                  ),
                  SizedBox(height: Sizes.s8.h),
                  PrimaryText(
                    training.description ?? "",
                    size: Sizes.s16.sp,
                  ),
                  SizedBox(height: Sizes.s16.h),

                  // Trainer
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey),
                      SizedBox(width: 5),
                      PrimaryText(
                        "Trainer: ${training.trainerName}",
                        color: Colors.grey[600], size: Sizes.s16.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.s20.h),
                ],
              ),
            ),

            // Enroll Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle enroll action
                 SnackUtils.showSnak("Enrolled in ${training.name}");
                },
                child: PrimaryText("Enroll Now",color: Colors.white,),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.s40.w, vertical: Sizes.s15.h),
                  textStyle: TextStyle(fontSize: Sizes.s18.sp,color: Colors.white),
                  backgroundColor: AppColors.primary
                ),
              ),
            ),
            SizedBox(height: Sizes.s20.h),
          ],
        ),
      ),
    );
  }
}
