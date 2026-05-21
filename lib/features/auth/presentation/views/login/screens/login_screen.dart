import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:movies_app/core/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/login_form.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/login_header.dart';
import 'package:movies_app/features/auth/presentation/views/register/widgets/register_prompt.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/social_login_section.dart';
import '../../forgot_password/screens/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          UIUtils.showLoadingDialog(context);
        } else if (state is AuthSuccess) {
          UIUtils.hideLoadingDialog(context);
          UIUtils.showToast("Login Successful");
          // TODO: Navigate to Home Screen
        } else if (state is AuthFailure) {
          UIUtils.hideLoadingDialog(context);
          UIUtils.showToast(state.message, isError: true);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                LoginForm(
                  formKey: GlobalKey<FormState>(),
                  emailController: TextEditingController(),
                  passwordController: TextEditingController(),
                  isLoading: false,
                  onLoginPressed: () {},
                  onForgotPasswordPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                const RegisterPrompt(),
                20.verticalSpace,
                SocialLoginSection(
                  onGoogleLoginPressed: () {
                    context.read<AuthCubit>().signInWithGoogle();
                  },
                ),
                30.verticalSpace,
                const LanguageSwitcher(),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
