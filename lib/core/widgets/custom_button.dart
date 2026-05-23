import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String txtButton;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final TextStyle? textStyle;
  final IconData? icon;
  final String? svgIcon;

  const CustomButton({
    super.key,
    required this.txtButton,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.borderRadius,
    this.textStyle,
    this.icon,
    this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        ),
        minimumSize: Size(width ?? double.infinity, height ?? 48.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgIcon != null) ...[
            SvgPicture.asset(
              svgIcon!,
              width: 20.sp,
              height: 20.sp,
              colorFilter: foregroundColor != null
                  ? ColorFilter.mode(foregroundColor!, BlendMode.srcIn)
                  : null,
            ),
            8.horizontalSpace,
          ] else if (icon != null) ...[
            Icon(icon, size: 20.sp),
            8.horizontalSpace,
          ],
          Text(
            txtButton,
            style:
                textStyle ??
                TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
