import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class EditProfileFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback? onResetPassword;

  const EditProfileFormSection({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          40.verticalSpace,
          CustomTextField(
            controller: nameController,
            hintText: 'Full Name',
            prefixIcon: const Icon(Icons.person),
            validator: AppValidators.validateName,
          ),
          16.verticalSpace,
          CustomTextField(
            controller: phoneController,
            hintText: 'Phone Number',
            prefixIcon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
            validator: AppValidators.validatePhone,
          ),
          16.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onResetPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Reset Password',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
