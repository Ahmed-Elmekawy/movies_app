import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_movie_details_use_case.dart';
import '../../domain/use_cases/get_similar_movies_use_case.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  final GetSimilarMoviesUseCase _getSimilarMoviesUseCase;

  MovieDetailsCubit(
    this._getMovieDetailsUseCase,
    this._getSimilarMoviesUseCase,
  ) : super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    
    final movieResult = await _getMovieDetailsUseCase(movieId);
    final similarResult = await _getSimilarMoviesUseCase(movieId);

    movieResult.fold(
      (failure) => emit(MovieDetailsFailure(failure.message)),
      (movie) {
        similarResult.fold(
          (failure) => emit(MovieDetailsSuccess(movie, [])),
          (similarMovies) => emit(MovieDetailsSuccess(movie, similarMovies)),
        );
      },
    );
  }
}
