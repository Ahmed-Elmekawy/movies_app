import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_colors.dart';
import 'navigation_service.dart';

class UIUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            16.verticalSpace,
            Text("Loading...", style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    NavigationService.goBack(context);
  }

  static void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? AppColors.red : AppColors.green,
      textColor: AppColors.white,
      fontSize: 16.sp,
    );
  }
}
