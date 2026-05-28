import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../utils/app_colors.dart';
import '../utils/navigation_service.dart';

class CustomWarningDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final String? cancelText;
  final VoidCallback onActionPressed;
  final Color? actionColor;
  final IconData? icon;
  final Widget? content;

  const CustomWarningDialog({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    this.cancelText,
    required this.onActionPressed,
    this.actionColor,
    this.icon,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActionColor = actionColor ?? theme.colorScheme.error;

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: REdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Warning Icon
            Container(
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: effectiveActionColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.warning_amber_rounded,
                color: effectiveActionColor,
                size: 48.sp,
              ),
            ),
            24.verticalSpace,
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            12.verticalSpace,
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
              ),
            ),
            if (content != null) ...[
              16.verticalSpace,
              content!,
            ],
            32.verticalSpace,
            // Actions
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: TextButton(
                    onPressed: () => NavigationService.goBack(context),
                    style: TextButton.styleFrom(
                      padding: REdgeInsets.symmetric(vertical: 14),
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                          color: AppColors.white.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Text(
                      cancelText ?? context.l10n.cancel,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                16.horizontalSpace,
                // Action Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      NavigationService.goBack(context);
                      onActionPressed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: effectiveActionColor,
                      foregroundColor: AppColors.white,
                      padding: REdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      actionText,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    required String description,
    required String actionText,
    String? cancelText,
    required VoidCallback onActionPressed,
    Color? actionColor,
    IconData? icon,
    Widget? content,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomWarningDialog(
        title: title,
        description: description,
        actionText: actionText,
        cancelText: cancelText,
        onActionPressed: onActionPressed,
        actionColor: actionColor,
        icon: icon,
        content: content,
      ),
    );
  }
}
