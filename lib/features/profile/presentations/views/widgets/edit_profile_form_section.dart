import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class EditProfileFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const EditProfileFormSection({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          40.verticalSpace,
          // ── Name Field ───────────────────────────────────────────────────
          CustomTextField(
            controller: nameController,
            hintText: 'Full Name',
            prefixIcon: Icons.person,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Name is required' : null,
          ),
          16.verticalSpace,
          // ── Phone Field ──────────────────────────────────────────────────
          CustomTextField(
            controller: phoneController,
            hintText: 'Phone Number',
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Phone is required' : null,
          ),
          16.verticalSpace,
          // ── Reset Password link ──────────────────────────────────────────
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                // TODO: navigate to reset password screen
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Reset Password',
                style: TextStyle(color: AppColors.white, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
