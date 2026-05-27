import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:movies_app/core/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/views/register/widgets/avatar_carousel.dart';
import 'package:movies_app/features/auth/presentation/views/login/widgets/login_prompt.dart';
import 'package:movies_app/features/auth/presentation/views/register/widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectedAvatarIndex = 0;
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
    final theme = Theme.of(context);
    final avatarKeys = AppConstants.avatarKeys;
    
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          UIUtils.showToast("Registration Successful");
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginScreen,
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
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.primary),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Register',
              style: TextStyle(
                color: theme.colorScheme.primary,
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
                    isLoading: isLoading,
                    onRegisterPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                              phone: _phoneController.text.trim(),
                              avatar: avatarKeys[_selectedAvatarIndex],
                            );
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
      },
    );
  }
}
