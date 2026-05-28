import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
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
    final l10n = context.l10n;
    return Form(
      key: formKey,
      child: Column(
        children: [
          40.verticalSpace,
          CustomTextField(
            controller: nameController,
            hintText: l10n.fullName,
            prefixIcon: const Icon(Icons.person),
            validator: (value) => AppValidators.validateName(
              value,
              nameRequired: l10n.nameRequired,
            ),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: phoneController,
            hintText: l10n.phoneNumber,
            prefixIcon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
            validator: (value) => AppValidators.validatePhone(
              value,
              phoneRequired: l10n.phoneRequired,
              invalidPhone: l10n.invalidPhone,
            ),
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
                l10n.resetPassword,
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
