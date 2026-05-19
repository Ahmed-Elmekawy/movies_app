import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import 'widgets/avatar_carousel.dart';
import 'widgets/language_switcher.dart';
import 'widgets/login_prompt.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectedAvatarIndex = 1;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryVariant,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Register',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AvatarCarousel(
                selectedAvatarIndex: _selectedAvatarIndex,
                onAvatarChanged: (index) {
                  setState(() {
                    _selectedAvatarIndex = index;
                  });
                },
              ),
              24.verticalSpace,
              RegisterForm(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                phoneController: _phoneController,
                isLoading: false,
                onRegisterPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle registration logic
                  }
                },
              ),
              16.verticalSpace,
              const LoginPrompt(),
              24.verticalSpace,
              const LanguageSwitcher(),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
