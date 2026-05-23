import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/empty_view.dart';
import '../../../../../core/widgets/movie_item.dart';

/// Mock movie data for design preview
class _MockMovie {
  final String rating;

  const _MockMovie({
    required this.rating,
  });
}

const _mockMovies = [
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
  _MockMovie(rating: '7.7'),
];

class MoviesGridTab extends StatelessWidget {
  final bool isEmpty;

  const MoviesGridTab({super.key, this.isEmpty = true});

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const AppEmptyView(
        imagePath: AppImages.empty,
        title: 'No Movies Yet',
        subtitle: 'Your watch list is empty',
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
      itemCount: _mockMovies.length,
      itemBuilder: (_, index) => MovieItem(
        rating: _mockMovies[index].rating,
      ),
    );
  }
}
