import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileAvatarSection extends StatelessWidget {
  final String avatarPath;
  final VoidCallback onTap;

  const EditProfileAvatarSection({
    super.key,
    required this.avatarPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(radius: 62.r, backgroundImage: AssetImage(avatarPath)),
          Container(
            padding: REdgeInsets.all(7),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.edit_rounded,
              size: 16.sp,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
