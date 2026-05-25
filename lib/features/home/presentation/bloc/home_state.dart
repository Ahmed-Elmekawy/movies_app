import '../../domain/entites/home_movie_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<HomeMovieEntity> availableNowMovies;
  final Map<String, List<HomeMovieEntity>> categoryMovies;

  HomeSuccess({
    required this.availableNowMovies,
    required this.categoryMovies,
  });
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
