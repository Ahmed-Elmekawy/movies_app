import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/utils/navigation_service.dart';


class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't Have Account ? ",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            NavigationService.navigateTo(context, AppRoutes.registerScreen);
          },
          child: Text(
            'Create One',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
