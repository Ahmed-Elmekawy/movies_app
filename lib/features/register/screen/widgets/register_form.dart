import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

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
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: nameController,
            hintText: 'Name',
            validator: AppValidators.validateName,
            prefixIcon: _buildPrefixIcon(AppSVGs.nameIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: emailController,
            hintText: 'Email',
            validator: AppValidators.validateEmail,
            prefixIcon: _buildPrefixIcon(AppSVGs.emailIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
            validator: AppValidators.validatePassword,
            prefixIcon: _buildPrefixIcon(AppSVGs.passwordIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            isPassword: true,
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              passwordController.text,
            ),
            prefixIcon: _buildPrefixIcon(AppSVGs.passwordIcon),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: phoneController,
            hintText: 'Phone Number',
            keyboardType: TextInputType.phone,
            validator: AppValidators.validatePhone,
            prefixIcon: _buildPrefixIcon(AppSVGs.phoneIcon),
          ),
          24.verticalSpace,
          isLoading
              ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary))
              : CustomButton(
                  txtButton: 'Create Account',
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
