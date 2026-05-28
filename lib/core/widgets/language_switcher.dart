import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/bloc/locale/locale_cubit.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeCubit = context.watch<LocaleCubit>();
    final isEnglish = localeCubit.isEnglish();

    return GestureDetector(
      onTap: () {
        final newLocale = isEnglish ? 'ar' : 'en';
        localeCubit.changeLanguage(newLocale);
      },
      child: Container(
        width: 76.w,
        height: 38.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Sliding Indicator
            AnimatedAlign(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutBack,
              alignment: isEnglish ? AlignmentGeometry.centerStart : AlignmentGeometry.centerEnd,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Flags
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isEnglish ? 1.0 : 0.6,
                      child: Text(
                        '🇺🇸',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: !isEnglish ? 1.0 : 0.6,
                      child: Text(
                        '🇪🇬',
                        style: TextStyle(fontSize: 18.sp),
                      ),
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
