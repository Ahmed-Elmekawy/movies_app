import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_button.dart';

class AppErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const AppErrorView({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80.r,
              color: Theme.of(context).colorScheme.error,
            ),
            24.verticalSpace,
            Text(
              message ?? "Oops! Something went wrong",
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              24.verticalSpace,
              SizedBox(
                width: 160.w,
                child: CustomButton(
                  txtButton: "Retry",
                  onPressed: onRetry!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
