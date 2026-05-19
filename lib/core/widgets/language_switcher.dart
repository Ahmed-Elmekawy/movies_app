import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEnglish = !isEnglish;
          });
        },
        child: Container(
          width: 80.w,
          height: 36.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: theme.colorScheme.primary, width: 2),
            color: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                alignment: isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Text('🇺🇸', style: TextStyle(fontSize: 18.sp)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Text('🇪🇬', style: TextStyle(fontSize: 18.sp)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
