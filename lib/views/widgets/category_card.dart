part of 'widgets.dart';

class CategoryCard extends StatefulWidget {
  final Categories category;
  const CategoryCard(this.category,{super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category tap
        print("Selected: ${widget.category.name}");
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s16.w),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.s16.w),
              child:ImageView(
                imageUrl:widget.category.coverImageUrl!,
                width: ScreenUtil().screenWidth -32,
                height: Sizes.s200.h,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s16.w),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: Sizes.s20.h,
              left: Sizes.s20.w,
              child: PrimaryText(
                widget.category.name!,
                  color: Colors.white,
                  size: Sizes.s20.sp,
                  weight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
