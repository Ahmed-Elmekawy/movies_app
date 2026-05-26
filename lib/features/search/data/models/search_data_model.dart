import 'search_movie_model.dart';

class SearchDataModel {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<SearchMovieModel>? movies;

  SearchDataModel({this.movieCount, this.limit, this.pageNumber, this.movies});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = <SearchMovieModel>[];
      json['movies'].forEach((v) {
        movies!.add(SearchMovieModel.fromJson(v));
      });
    }
  }
}
