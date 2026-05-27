import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/entities/movie_entity.dart' as detail;
import '../../../../../core/widgets/movie_item.dart';

class MovieSimilarSection extends StatelessWidget {
  final List<detail.MovieEntity> similarMovies;

  const MovieSimilarSection({super.key, required this.similarMovies});

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
      itemCount: similarMovies.length,
      itemBuilder: (context, index) {
        final movie = similarMovies[index];
        return MovieItem(
          imagePath: movie.mediumCoverImage,
          rating: movie.rating,
          movieId: movie.id,
        );
      },
    );
  }
}
