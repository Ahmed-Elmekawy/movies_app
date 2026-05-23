import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/widgets/custom_button.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGoogleLoginPressed;

  const SocialLoginSection({super.key, required this.onGoogleLoginPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: theme.colorScheme.primary, endIndent: 10),
            ),
            Text(
              'OR',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
            Expanded(
              child: Divider(color: theme.colorScheme.primary, indent: 10),
            ),
          ],
        ),
        20.verticalSpace,
        CustomButton(
          txtButton: 'Login With Google',
          onPressed: onGoogleLoginPressed,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onPrimary,
          ),
          svgIcon: AppSVGs.googleIcon,
        ),
      ],
    );
  }
}
