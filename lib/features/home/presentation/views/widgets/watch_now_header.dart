import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_assets.dart';


class WatchNowHeader extends StatelessWidget {
  const WatchNowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.watchNow,
        height: 120.h,
        width: 350.w,
        fit: BoxFit.contain,
      ),
    );
  }
}
