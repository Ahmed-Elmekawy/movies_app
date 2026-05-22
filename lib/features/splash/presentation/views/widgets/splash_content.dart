import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';


class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage(AppImages.splashLogo),
            width: 120.w,
            height: 120.h,
          ),
          CircularProgressIndicator(color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}