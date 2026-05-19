import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGoogleLoginPressed;

  const SocialLoginSection({
    super.key,
    required this.onGoogleLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.primary, endIndent: 10)),
            Text(
              'OR',
              style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
            ),
            const Expanded(child: Divider(color: AppColors.primary, indent: 10)),
          ],
        ),
        20.verticalSpace,
        CustomButton(
          txtButton: 'Login With Google',
          onPressed: onGoogleLoginPressed,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryVariant,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryVariant,
          ),
          icon: Icons.g_mobiledata,
        ),
      ],
    );
  }
}
