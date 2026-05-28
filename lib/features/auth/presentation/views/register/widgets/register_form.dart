import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_validators.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final bool isLoading;
  final VoidCallback onRegisterPressed;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.isLoading,
    required this.onRegisterPressed,
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
            controller: nameController,
            hintText: l10n.name,
            validator: (value) => AppValidators.validateName(
              value,
              nameRequired: l10n.nameRequired,
            ),
            prefixIcon: _buildPrefixIcon(AppSVGs.nameIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: emailController,
            hintText: l10n.email,
            validator: (value) => AppValidators.validateEmail(
              value,
              emailRequired: l10n.emailRequired,
              invalidEmail: l10n.invalidEmail,
            ),
            prefixIcon: _buildPrefixIcon(AppSVGs.emailIcon),
          ),
          16.verticalSpace,
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
            prefixIcon: _buildPrefixIcon(AppSVGs.passwordIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: confirmPasswordController,
            hintText: l10n.confirmPassword,
            isPassword: true,
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              passwordController.text,
              confirmPasswordRequired: l10n.confirmPasswordRequired,
              passwordsDoNotMatch: l10n.passwordsDoNotMatch,
            ),
            prefixIcon: _buildPrefixIcon(AppSVGs.passwordIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: phoneController,
            hintText: l10n.phoneNumber,
            keyboardType: TextInputType.phone,
            validator: (value) => AppValidators.validatePhone(
              value,
              phoneRequired: l10n.phoneRequired,
              invalidPhone: l10n.invalidPhone,
            ),
            prefixIcon: _buildPrefixIcon(AppSVGs.phoneIcon),
          ),
          24.verticalSpace,
          isLoading
              ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary))
              : CustomButton(
                  txtButton: l10n.createAccount,
                  onPressed: onRegisterPressed,
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  borderRadius: 12.r,
                  height: 52.h,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildPrefixIcon(String iconPath) {
    return Padding(
      padding: EdgeInsets.all(14.r),
      child: SvgPicture.asset(
        iconPath,
        width: 20.w,
        height: 20.h,
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      ),
    );
  }
}
