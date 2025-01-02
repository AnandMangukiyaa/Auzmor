part of 'widgets.dart';

class TrainingCard extends StatelessWidget {
  final Training training;


  const TrainingCard(this.training);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s16.sp),
        ),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.s16.w)),
              child: ImageView(
                imageUrl:training.imageUrl!,
                height: Sizes.s200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Sizes.s16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    training.name ?? "",
                      size: Sizes.s20.sp,
                      weight: FontWeight.bold,
                  ),
                  SizedBox(height: Sizes.s8.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: Sizes.s6.w),
                      PrimaryText(
                        training.location ?? "",
                       color: Colors.grey[600],
                      ),
                    ],
                  ),
                  SizedBox(height: Sizes.s8.h),
                  PrimaryText(
                    training.description ?? "",
                    size: Sizes.s16.sp,
                  ),
                  SizedBox(height: Sizes.s16.h),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey),
                      SizedBox(width: 5),
                      PrimaryText(
                        "Trainer: ${training.trainerName}",
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
