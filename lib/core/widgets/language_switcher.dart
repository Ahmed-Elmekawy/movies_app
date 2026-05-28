import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/bloc/locale/locale_cubit.dart';
import '../utils/app_colors.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final localeCubit = context.watch<LocaleCubit>();
    final isEnglish = localeCubit.isEnglish();

    return GestureDetector(
      onTap: () {
        final newLocale = isEnglish ? 'ar' : 'en';
        localeCubit.changeLanguage(newLocale);
      },
      child: Container(
        width: 80.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: theme.primaryColor,
            width: 2,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: isEnglish ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 32.w,
                height: 32.h,
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor,
                ),
              ),
            ),
            // The flags
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '🇺🇸',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '🇪🇬',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
