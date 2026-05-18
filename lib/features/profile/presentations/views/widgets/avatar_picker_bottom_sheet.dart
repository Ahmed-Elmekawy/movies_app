import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';

class AvatarPickerBottomSheet extends StatefulWidget {
  final String selectedAvatar;
  final ValueChanged<String> onAvatarSelected;

  const AvatarPickerBottomSheet({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  static Future<String?> show(
    BuildContext context, {
    required String currentAvatar,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => AvatarPickerBottomSheet(
        selectedAvatar: currentAvatar,
        onAvatarSelected: (avatar) => Navigator.of(ctx).pop(avatar),
      ),
    );
  }

  @override
  State<AvatarPickerBottomSheet> createState() =>
      _AvatarPickerBottomSheetState();
}

class _AvatarPickerBottomSheetState extends State<AvatarPickerBottomSheet> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedAvatar;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              itemCount: AppImages.avatars.length,
              itemBuilder: (_, index) {
                final avatar = AppImages.avatars[index];
                final isSelected = avatar == _selected;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selected = avatar);
                    widget.onAvatarSelected(avatar);
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
                      child: Image.asset(avatar, fit: BoxFit.cover),
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
