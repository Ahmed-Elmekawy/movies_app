import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_assets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.verticalSpace,
        Image.asset(
          AppImages.splashLogo,
          height: 150.h,
        ),
        40.verticalSpace,
      ],
    );
  }
}
