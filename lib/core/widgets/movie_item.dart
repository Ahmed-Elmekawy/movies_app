import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/navigation_service.dart';
import '../utils/app_routes.dart';
import 'custom_network_image.dart';

class MovieItem extends StatelessWidget {
  final String? imagePath;
  final String rating;
  final int? movieId;

  const MovieItem({
    super.key,
    this.imagePath,
    required this.rating,
    this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => NavigationService.navigateTo(context, AppRoutes.movieDetails,arguments:movieId),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: imagePath!,
            ),
            Positioned(
              top: 6.h,
              left: 6.w,
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 20.sp,
                    ),
                    2.horizontalSpace,
                    Text(
                      rating,
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
