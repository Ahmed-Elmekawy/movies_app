import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/empty_view.dart';
import '../../../../../core/widgets/movie_item.dart';
import '../../../../../core/widgets/movies_grid.dart';
import '../../bloc/search_cubit.dart';
import '../../bloc/search_state.dart';

class SearchResultsView extends StatelessWidget {
  final ScrollController scrollController;

  const SearchResultsView({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const AppEmptyView(imagePath: AppImages.empty);
        }

        if (state is SearchLoading && state.movies.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchFailure && state.movies.isEmpty) {
          return Center(child: Text(state.message));
        }

        if (state.movies.isEmpty) {
          return const AppEmptyView(imagePath: AppImages.empty);
        }

        return MoviesGrid(
          controller: scrollController,
          itemCount: state.movies.length + (state is SearchPaginationLoading ? 1 : 0),
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
