import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_validators.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: emailController,
            hintText: l10n.email,
            validator: (value) => AppValidators.validateEmail(
              value,
              emailRequired: l10n.emailRequired,
              invalidEmail: l10n.invalidEmail,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(14.r),
              child: SvgPicture.asset(
                AppSVGs.emailIcon,
                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
          ),
          20.verticalSpace,
          CustomTextField(
            controller: passwordController,
            hintText: l10n.password,
            isPassword: true,
            validator: (value) => AppValidators.validatePassword(
              value,
              passwordRequired: l10n.passwordRequired,
              passwordTooShort: l10n.passwordTooShort,
              passwordInvalid: l10n.passwordInvalid,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(14.r),
              child: SvgPicture.asset(
                AppSVGs.passwordIcon,
                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPasswordPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l10n.forgotPassword,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          24.verticalSpace,
          isLoading
              ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary))
              : CustomButton(
                  txtButton: l10n.login,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onLoginPressed();
                    }
                  },
                  height: 52.h,
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
        ],
      ),
    );
  }
}
