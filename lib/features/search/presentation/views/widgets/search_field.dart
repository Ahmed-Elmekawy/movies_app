import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: context.l10n.search,
      prefixIcon: Padding(
        padding: REdgeInsets.all(12),
        child: Image.asset(
          AppImages.searchIcon,
          color: AppColors.white,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
