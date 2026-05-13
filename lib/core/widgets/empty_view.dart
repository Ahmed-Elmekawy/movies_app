import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppEmptyView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const AppEmptyView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
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
              icon,
              size: 80.sp,
            ),
            24.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              8.verticalSpace,
              Text(
                subtitle!,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
