import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_search_movies_use_case.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchMoviesUseCase getSearchMoviesUseCase;

  SearchCubit(this.getSearchMoviesUseCase) : super(SearchInitial());

  String _currentQuery = '';
  int _currentPage = 1;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    _currentQuery = query;
    _currentPage = 1;
    emit(SearchLoading());

    final result = await getSearchMoviesUseCase(_currentQuery, _currentPage);

    result.fold(
      (failure) => emit(SearchFailure(failure.message)),
      (movies) {
        emit(SearchSuccess(
          movies: movies,
          page: _currentPage,
          hasMore: movies.isNotEmpty,
        ));
      },
    );
  }

  Future<void> loadMoreMovies() async {
    final currentState = state;
    
    if (currentState is SearchSuccess && currentState.hasMore) {
      final oldMovies = currentState.movies;
      emit(SearchPaginationLoading(oldMovies));
      
      _currentPage++;
      final result = await getSearchMoviesUseCase(_currentQuery, _currentPage);

      result.fold(
        (failure) {
          _currentPage--;
          emit(SearchPaginationFailure(oldMovies, failure.message));
        },
        (newMovies) {
          if (newMovies.isEmpty) {
            emit(SearchSuccess(
              movies: oldMovies,
              page: _currentPage - 1,
              hasMore: false,
            ));
          } else {
            emit(SearchSuccess(
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
