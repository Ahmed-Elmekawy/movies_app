import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import '../../../../../core/widgets/error_view.dart';
import '../../../../../core/widgets/movie_item.dart';
import '../../../../../core/widgets/movies_grid.dart';
import '../../bloc/explore_cubit.dart';
import '../../bloc/explore_state.dart';

class ExploreResultsView extends StatelessWidget {
  final ScrollController scrollController;

  const ExploreResultsView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        if (state is ExploreLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ExploreFailure) {
          return AppErrorView(
            message: state.message,
            onRetry: () => context.read<ExploreCubit>().getMoviesByGenre(
                  context.read<ExploreCubit>().currentGenre,
                ),
          );
        }

        if (state.movies.isEmpty && state is! ExploreInitial) {
          return Center(child: Text(l10n.noMoviesFoundForGenre));
        }

        if (state is ExploreInitial) {
          return Center(child: Text(l10n.selectGenreToExplore));
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
