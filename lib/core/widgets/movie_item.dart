import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class MovieItem extends StatelessWidget {
  final String imagePath;
  final String rating;

  const MovieItem({
    super.key,
    this.imagePath = AppImages.movie,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Movie Poster
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          // Rating chip
          Positioned(
            top: 6,
            left: 6,
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primaryVariant.withValues(alpha: 0.88),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.primary,
                    size: 11.sp,
                  ),
                  2.horizontalSpace,
                  Text(
                    rating,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
