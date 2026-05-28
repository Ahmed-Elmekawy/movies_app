import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/navigation_service.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:movies_app/core/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/login_form.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/login_header.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/register_prompt.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/social_login_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          UIUtils.showToast(context.l10n.loginSuccessful);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        } else if (state is AuthFailure) {
          UIUtils.showToast(state.message, isError: true);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  const LoginHeader(),
                  LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    isLoading: isLoading,
                    onLoginPressed: () {
                      context.read<AuthCubit>().login(
                        _emailController.text.trim(),
                        _passwordController.text,
                      );
                    },
                    onForgotPasswordPressed: () {
                      NavigationService.navigateTo(
                        context,
                        AppRoutes.forgotPasswordScreen,
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
        );
      },
    );
  }
}
