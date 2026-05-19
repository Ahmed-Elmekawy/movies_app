import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../register/screen/widgets/language_switcher.dart';
import 'forgot_password_screen.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import 'widgets/register_prompt.dart';
import 'widgets/social_login_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryVariant,
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
                onGoogleLoginPressed: () {},
              ),
              30.verticalSpace,
              const LanguageSwitcher(),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
