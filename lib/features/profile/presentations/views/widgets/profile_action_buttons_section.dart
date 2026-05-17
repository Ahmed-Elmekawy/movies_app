import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class ProfileActionButtonsSection extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onExit;

  const ProfileActionButtonsSection({
    super.key,
    required this.onEditProfile,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Edit Profile
          Expanded(
            child: CustomButton(
              height: 46.h,
              txtButton: 'Edit Profile',
              onPressed: onEditProfile,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.primaryVariant,
            ),
          ),
          12.horizontalSpace,
          // Exit
          Expanded(
            child: CustomButton(
              height: 46.h,
              txtButton: 'Exit',
              icon: Icons.logout,
              onPressed: onExit,
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}