import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class AvatarCarousel extends StatelessWidget {
  final int selectedAvatarIndex;
  final ValueChanged<int> onAvatarChanged;

  const AvatarCarousel({
    super.key,
    required this.selectedAvatarIndex,
    required this.onAvatarChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: AppImages.avatars.length,
          itemBuilder: (context, index, realIndex) {
            final isSelected = index == selectedAvatarIndex;
            return _buildAvatarItem(
              index,
              isSelected: isSelected,
            );
          },
          options: CarouselOptions(
            height: 150.h,
            viewportFraction: 0.4,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            initialPage: selectedAvatarIndex,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              onAvatarChanged(index);
            },
          ),
        ),
        8.verticalSpace,
        Center(
          child: Text(
            'Avatar',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarItem(int index, {required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: isSelected ? 0 : 20.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFB1D8FF).withValues(alpha: isSelected ? 1.0 : 0.5),
      ),
      child: ClipOval(
        child: Image.asset(
          AppImages.avatars[index],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
