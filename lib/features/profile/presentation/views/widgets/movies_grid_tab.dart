import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/empty_view.dart';
import '../../../../../core/widgets/movie_item.dart';
import '../../../../auth/domain/entities/movie_entity.dart';

class MoviesGridTab extends StatelessWidget {
  final List<MovieEntity> movies;

  const MoviesGridTab({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const AppEmptyView(
        imagePath: AppImages.empty,
        title: 'No Movies Yet',
        subtitle: 'Your list is empty',
      );
    }

    return GridView.builder(
      padding: REdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (_, index) => MovieItem(
        imagePath: movies[index].mediumCoverImage,
        rating: movies[index].rating,
        movieId: movies[index].id,
      ),
    );
  }
}
