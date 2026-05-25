import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/movie_item.dart';
import '../../../domain/entites/home_movie_entity.dart';

class AvailableNowSection extends StatelessWidget {
  final List<HomeMovieEntity> movies;
  final ValueChanged<int>? onPageChanged;

  const AvailableNowSection({
    super.key,
    required this.movies,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          itemCount: movies.length,
          itemBuilder: (context, index, realIndex) {
            return MovieItem(
              movieId: movies[index].id,
              imagePath: movies[index].mediumCoverImage,
              rating: movies[index].rating.toString(),
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
