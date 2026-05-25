import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import '../../domain/entites/home_movie_entity.dart';
import '../../domain/use_cases/get_available_now_movies_use_case.dart';
import '../../domain/use_cases/get_category_movies_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAvailableNowMoviesUseCase getAvailableNowMoviesUseCase;
  final GetCategoryMoviesUseCase getCategoryMoviesUseCase;

  HomeCubit(this.getAvailableNowMoviesUseCase, this.getCategoryMoviesUseCase)
    : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());
    final availableNowMovies = await getAvailableNowMoviesUseCase();
    await availableNowMovies.fold(
      (failure) async => emit(HomeFailure(failure.message)),
      (availableNowMovies) async {
        final genres = _getRandomGenres(3);
        final Map<String, List<HomeMovieEntity>> categoryMovies = {};

        for (final genre in genres) {
          final result = await getCategoryMoviesUseCase(genre);
          result.fold(
            (failure) => null,
            (movies) => categoryMovies[genre] = movies,
          );
        }

        emit(
          HomeSuccess(
            availableNowMovies: availableNowMovies,
            categoryMovies: categoryMovies,
          ),
        );
      },
    );
  }

  List<String> _getRandomGenres(int count) {
    final List<String> allGenres = List.from(AppConstants.genres);
    allGenres.shuffle(Random());
    return allGenres.take(count).toList();
  }
}
