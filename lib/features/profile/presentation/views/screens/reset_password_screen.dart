import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../auth/presentation/bloc/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccess) {
          UIUtils.showToast('Password updated successfully. Please log in again.');
          Navigator.pop(context);
        } else if (state is AuthFailure) {
          UIUtils.showToast(state.message, isError: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Reset Password',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontSize: 18.sp,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  40.verticalSpace,
                  CustomTextField(
                    controller: _oldPasswordController,
                    hintText: 'Old Password',
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                    prefixIcon: const Icon(Icons.lock_open),
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'New Password',
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm New Password',
                    isPassword: true,
                    validator: (value) => AppValidators.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  40.verticalSpace,
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        txtButton: 'Update Password',
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().updatePassword(
                                        oldPassword: _oldPasswordController.text,
                                        newPassword: _passwordController.text,
                                      );
                                }
                              },
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        height: 52.h,
                        textStyle: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
