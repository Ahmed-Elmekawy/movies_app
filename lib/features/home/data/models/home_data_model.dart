import 'home_movie_model.dart';

class HomeDataModel {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<HomeMovieModel>? movies;

  HomeDataModel({this.movieCount, this.limit, this.pageNumber, this.movies});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = <HomeMovieModel>[];
      json['movies'].forEach((v) {
        movies!.add(HomeMovieModel.fromJson(v));
      });
    }
  }
}
