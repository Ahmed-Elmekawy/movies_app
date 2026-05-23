import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final int minLines;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      style: TextStyle(color: AppColors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.white.withValues(alpha: 0.6),
          fontSize: 14.sp,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppColors.white),
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: AppColors.secondaryVariant,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.red, width: 1.2),
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
