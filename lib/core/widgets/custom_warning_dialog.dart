import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/navigation_service.dart';

class CustomWarningDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final String cancelText;
  final VoidCallback onActionPressed;
  final Color? actionColor;
  final IconData? icon;

  const CustomWarningDialog({
    super.key,
    required this.title,
    required this.description,
    required this.actionText,
    this.cancelText = "Cancel",
    required this.onActionPressed,
    this.actionColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActionColor = actionColor ?? AppColors.red;

    return Dialog(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: REdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: effectiveActionColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.warning_amber_rounded,
                color: effectiveActionColor,
                size: 40.sp,
              ),
            ),
            20.verticalSpace,
            Text(title, textAlign: TextAlign.center),
            12.verticalSpace,
            Flexible(
              child: SingleChildScrollView(
                child: Text(description, textAlign: TextAlign.center),
              ),
            ),
            32.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => NavigationService.goBack(context),
                    style: OutlinedButton.styleFrom(
                      padding: REdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(cancelText),
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      NavigationService.goBack(context);
                      onActionPressed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: effectiveActionColor,
                      foregroundColor: AppColors.white,
                      padding: REdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      elevation: 0,
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(actionText),
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
    String cancelText = "Cancel",
    required VoidCallback onActionPressed,
    Color? actionColor,
    IconData? icon,
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
      ),
    );
  }
}
