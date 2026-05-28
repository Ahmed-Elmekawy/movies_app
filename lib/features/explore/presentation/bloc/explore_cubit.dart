import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_movies_by_genre_use_case.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;

  ExploreCubit(this.getMoviesByGenreUseCase) : super(ExploreInitial());

  String _currentGenre = 'Action';
  int _currentPage = 1;

  String get currentGenre => _currentGenre;

  Future<void> getMoviesByGenre(String genre) async {
    _currentGenre = genre;
    _currentPage = 1;
    emit(ExploreLoading());

    final result = await getMoviesByGenreUseCase(_currentGenre, _currentPage);

    result.fold(
          (failure) => emit(ExploreFailure(failure.message)),
          (movies) {
        emit(ExploreSuccess(
          movies: movies,
          page: _currentPage,
          hasMore: movies.isNotEmpty,
        ));
      },
    );
  }

  Future<void> loadMoreMovies() async {
    final currentState = state;

    if (currentState is ExploreSuccess && currentState.hasMore) {
      final oldMovies = currentState.movies;
      emit(ExplorePaginationLoading(oldMovies));

      _currentPage++;
      final result = await getMoviesByGenreUseCase(_currentGenre, _currentPage);

      result.fold(
            (failure) {
          _currentPage--;
          emit(ExplorePaginationFailure(oldMovies, failure.message));
          emit(ExploreSuccess(movies: oldMovies, page: _currentPage, hasMore: true));
        },
            (newMovies) {
          if (newMovies.isEmpty) {
            emit(ExploreSuccess(
              movies: oldMovies,
              page: _currentPage - 1,
              hasMore: false,
            ));
          } else {
            emit(ExploreSuccess(
              movies: oldMovies + newMovies,
              page: _currentPage,
              hasMore: true,
            ));
          }
        },
      );
    }
  }
}
