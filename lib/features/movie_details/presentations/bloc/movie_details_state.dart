import '../../domain/entities/movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieEntity movie;
  final List<MovieEntity> similarMovies;

  MovieDetailsSuccess(this.movie, this.similarMovies);
}

class MovieDetailsFailure extends MovieDetailsState {
  final String message;

  MovieDetailsFailure(this.message);
}
