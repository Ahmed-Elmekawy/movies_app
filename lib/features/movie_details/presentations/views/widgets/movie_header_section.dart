import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class MovieHeaderSection extends StatelessWidget {
  final String backdropPath;
  final String title;
  final int year;
  final VoidCallback onWatchPressed;

  const MovieHeaderSection({
    super.key,
    required this.backdropPath,
    required this.title,
    required this.year,
    required this.onWatchPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 350.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backdropPath,
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Colors.transparent,
                    theme.scaffoldBackgroundColor.withValues(alpha: 0.9),
                    theme.scaffoldBackgroundColor,
                  ],
                  stops: const [0.0, 0.2, 0.5, 0.85, 1.0],
                ),
              ),
            ),
          ),
          // Content
          Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.white,
                    size: 24.sp,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark,
                      color: AppColors.white,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              Container(
                alignment: Alignment.center,
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor,
                  border: Border.all(color: AppColors.white, width: 5.w),
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 28.sp,
                  color: AppColors.white,
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontSize: 22.sp,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      year.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    24.verticalSpace,
                    CustomButton(
                      onPressed: onWatchPressed,
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: AppColors.white,
                      height: 52.h,
                      width: double.infinity,
                      borderRadius: 12.r,
                      txtButton: 'Watch',
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
