import '../../domain/entities/explore_movie_entity.dart';

abstract class ExploreState {
  final List<ExploreMovieEntity> movies;
  ExploreState({this.movies = const []});
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final int page;
  final bool hasMore;

  ExploreSuccess({
    required super.movies,
    required this.page,
    this.hasMore = true,
  });

  ExploreSuccess copyWith({
    List<ExploreMovieEntity>? movies,
    int? page,
    bool? hasMore,
  }) {
    return ExploreSuccess(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ExplorePaginationLoading extends ExploreState {
  ExplorePaginationLoading(List<ExploreMovieEntity> movies) : super(movies: movies);
}

class ExploreFailure extends ExploreState {
  final String message;

  ExploreFailure(this.message);
}

class ExplorePaginationFailure extends ExploreState {
  final String message;

  ExplorePaginationFailure(List<ExploreMovieEntity> movies, this.message) : super(movies: movies);
}
