import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import 'package:movies_app/core/utils/app_validators.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_state.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          UIUtils.showLoadingDialog(context);
        } else if (state is ForgotPasswordEmailSent) {
           UIUtils.hideLoadingDialog(context);
           UIUtils.showToast(l10n.resetLinkSent);
           Navigator.pop(context);
        } else if (state is AuthFailure) {
          UIUtils.hideLoadingDialog(context);
          UIUtils.showToast(state.message, isError: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            l10n.forgotPassword,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
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
                  Image.asset(
                    AppImages.forgetPassword,
                    height: 380.h,
                    fit: BoxFit.contain,
                  ),
                  24.verticalSpace,
                  CustomTextField(
                    controller: _emailController,
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
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    txtButton: l10n.verifyEmail,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().forgotPassword(_emailController.text.trim());
                      }
                    },
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    height: 52.h,
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
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
