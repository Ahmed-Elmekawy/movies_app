import '../../domain/entites/search_movie_entity.dart';

abstract class SearchState {
  final List<SearchMovieEntity> movies;
  SearchState({this.movies = const []});
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final int page;
  final bool hasMore;

  SearchSuccess({
    required super.movies,
    required this.page,
    this.hasMore = true,
  });

  SearchSuccess copyWith({
    List<SearchMovieEntity>? movies,
    int? page,
    bool? hasMore,
  }) {
    return SearchSuccess(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class SearchPaginationLoading extends SearchState {
  SearchPaginationLoading(List<SearchMovieEntity> movies) : super(movies: movies);
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}

class SearchPaginationFailure extends SearchState {
  final String message;

  SearchPaginationFailure(List<SearchMovieEntity> movies, this.message) : super(movies: movies);
}
