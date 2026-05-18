import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieScreenshotsSection extends StatelessWidget {
  final List<String> screenshotPaths;

  const MovieScreenshotsSection({super.key, required this.screenshotPaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        screenshotPaths.length,
        (index) => Padding(
          padding: REdgeInsets.only(
            bottom: index == screenshotPaths.length - 1 ? 0 : 16,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              screenshotPaths[index],
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
