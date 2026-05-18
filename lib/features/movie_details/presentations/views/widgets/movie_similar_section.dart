import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/movie_item.dart';

class MovieSimilarSection extends StatelessWidget {
  final List<String> moviePosterPaths;
  final List<double> movieRatings;

  const MovieSimilarSection({
    super.key,
    required this.moviePosterPaths,
    required this.movieRatings,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 140 / 200,
      ),
      itemCount: moviePosterPaths.length,
      itemBuilder: (context, index) => MovieItem(
        imagePath: moviePosterPaths[index],
        rating: movieRatings[index].toString(),
      ),
    );
  }
}
