import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_assets.dart';

class AppEmptyView extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? subtitle;
  final double? imageSize;

  const AppEmptyView({
    super.key,
    this.imagePath,
    this.title,
    this.subtitle,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath ?? AppImages.empty,
              width: imageSize ?? 120.w,
              fit: BoxFit.contain,
            ),
            if (title != null || subtitle == null && title == null) ...[
              24.verticalSpace,
              Text(
                title ?? context.l10n.noResultsFound,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
            if (subtitle != null) ...[
              8.verticalSpace,
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
