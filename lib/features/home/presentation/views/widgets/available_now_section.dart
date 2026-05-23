import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/movie_item.dart';

class AvailableNowSection extends StatelessWidget {
  final ValueChanged<int>? onPageChanged;

  const AvailableNowSection({
    super.key,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final images = [
      AppImages.screenshot1,
      AppImages.screenshot2,
      AppImages.screenshot3,
    ];

    return Column(
      children: [
        Image.asset(
          AppImages.availableNow,
          height: 90.h,
          width: 260.w,
          fit: BoxFit.contain,
        ),
        20.verticalSpace,
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return MovieItem(
              imagePath: images[index],
              rating: '7.7',
            );
          },
          options: CarouselOptions(
            height: 350.h,
            viewportFraction: 0.65,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              onPageChanged?.call(index);
            },
          ),
        ),
      ],
    );
  }
}
