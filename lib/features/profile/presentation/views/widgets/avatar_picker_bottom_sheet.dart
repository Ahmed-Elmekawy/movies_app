import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_constants.dart';

class AvatarPickerBottomSheet extends StatefulWidget {
  final String selectedAvatarKey;
  final ValueChanged<String> onAvatarSelected;

  const AvatarPickerBottomSheet({
    super.key,
    required this.selectedAvatarKey,
    required this.onAvatarSelected,
  });

  static Future<String?> show(
    BuildContext context, {
    required String currentAvatarKey,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => AvatarPickerBottomSheet(
        selectedAvatarKey: currentAvatarKey,
        onAvatarSelected: (key) => Navigator.of(context).pop(key),
      ),
    );
  }

  @override
  State<AvatarPickerBottomSheet> createState() =>
      _AvatarPickerBottomSheetState();
}

class _AvatarPickerBottomSheetState extends State<AvatarPickerBottomSheet> {
  late String _selectedKey;

  @override
  void initState() {
    super.initState();
    _selectedKey = widget.selectedAvatarKey;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final keys = AppConstants.avatarKeys;

    return SafeArea(
      child: Padding(
        padding: REdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            20.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: keys.length,
              itemBuilder: (_, index) {
                final key = keys[index];
                final avatarPath = AppConstants.getAvatarPath(key);
                final isSelected = key == _selectedKey;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedKey = key);
                    widget.onAvatarSelected(key);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.15),
                        width: isSelected ? 3 : 1.5,
                      ),
                      color: isSelected
                          ? colorScheme.primary.withValues(alpha: 0.12)
                          : Colors.transparent,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Image.asset(avatarPath, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
