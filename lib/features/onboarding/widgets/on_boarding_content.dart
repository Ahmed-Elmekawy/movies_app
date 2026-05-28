import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../../../core/widgets/custom_button.dart';
import '../model/on_boarding_model.dart';

class OnBoardingContent extends StatelessWidget {
  final OnBoardingModel model;
  final bool isFirst;
  final bool isLast;
  final bool isSecond;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnBoardingContent({
    super.key,
    required this.model,
    required this.isFirst,
    required this.isLast,
    required this.isSecond,
    required this.onNext,
    required this.onBack,
  });

  String _getTitle(BuildContext context) {
    final l10n = context.l10n;
    final index = OnBoardingModel.onBoardingList.indexOf(model);
    switch (index) {
      case 0: return l10n.onboardingTitle1;
      case 1: return l10n.onboardingTitle2;
      case 2: return l10n.onboardingTitle3;
      case 3: return l10n.onboardingTitle4;
      case 4: return l10n.onboardingTitle5;
      case 5: return l10n.onboardingTitle6;
      default: return model.title;
    }
  }

  String? _getDescription(BuildContext context) {
    final l10n = context.l10n;
    final index = OnBoardingModel.onBoardingList.indexOf(model);
    switch (index) {
      case 0: return l10n.onboardingDesc1;
      case 1: return l10n.onboardingDesc2;
      case 2: return l10n.onboardingDesc3;
      case 3: return l10n.onboardingDesc4;
      case 4: return l10n.onboardingDesc5;
      default: return model.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _getTitle(context);
    final description = _getDescription(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 35.h),
        decoration: BoxDecoration(
          color: isFirst ? Colors.transparent : theme.scaffoldBackgroundColor,
          borderRadius: isFirst
              ? BorderRadius.zero
              : BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Title(title: title),
            if (description != null && description.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _Description(description: description),
            ],
            SizedBox(height: 32.h),
            _ActionButtons(
              isFirst: isFirst,
              isLast: isLast,
              isSecond: isSecond,
              onNext: onNext,
              onBack: onBack,
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      textAlign: TextAlign.center,
      style: theme.textTheme.displayLarge?.copyWith(
        fontSize: 32.sp,
        height: 1.2,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String description;
  const _Description({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      description,
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
        fontSize: 16.sp,
        height: 1.4,
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isSecond;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _ActionButtons({
    required this.isFirst,
    required this.isLast,
    required this.isSecond,
    required this.onNext,
    required this.onBack,
  });

  String _nextButtonText(BuildContext context) {
    if (isFirst) return context.l10n.exploreNow;
    if (isLast) return context.l10n.finish;
    return context.l10n.next;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CustomButton(
          txtButton: _nextButtonText(context),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          onPressed: onNext,
          height: 55.h,
        ),
        if (!isFirst && !isSecond) ...[
          SizedBox(height: 12.h),
          _BackButton(onPressed: onBack),
        ],
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          context.l10n.back,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
