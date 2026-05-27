import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/movie_item.dart';
import '../../../../../core/widgets/movies_grid.dart';
import '../../bloc/explore_cubit.dart';
import '../../bloc/explore_state.dart';

class ExploreResultsView extends StatelessWidget {
  final ScrollController scrollController;

  const ExploreResultsView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        if (state is ExploreLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ExploreFailure) {
          return Center(child: Text(state.message));
        }

        if (state.movies.isEmpty && state is! ExploreInitial) {
          return const Center(child: Text('No movies found for this genre.'));
        }

        if (state is ExploreInitial) {
          return const Center(child: Text('Select a genre to explore movies.'));
        }

        return MoviesGrid(
          controller: scrollController,
          itemCount:
              state.movies.length + (state is ExplorePaginationLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < state.movies.length) {
              final movie = state.movies[index];
              return MovieItem(
                imagePath: movie.mediumCoverImage,
                rating: movie.rating,
                movieId: movie.id,
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}
