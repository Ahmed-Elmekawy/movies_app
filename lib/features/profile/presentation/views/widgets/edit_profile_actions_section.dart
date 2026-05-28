import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class EditProfileActionsSection extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const EditProfileActionsSection({
    super.key,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Padding(
      padding: REdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: CustomButton(
              txtButton: l10n.deleteAccount,
              onPressed: onDelete,
              backgroundColor: colorScheme.error,
              foregroundColor: AppColors.white,
            ),
          ),
          12.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: CustomButton(
              txtButton: l10n.updateData,
              onPressed: onUpdate,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
