import 'movie_model.dart';
import 'meta_model.dart';

class SimilarMoviesModel {
  String? status;
  String? statusMessage;
  SimilarMoviesData? data;
  MetaModel? meta;

  SimilarMoviesModel({this.status, this.statusMessage, this.data, this.meta});

  SimilarMoviesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? SimilarMoviesData.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? MetaModel.fromJson(json['@meta']) : null;
  }
}

class SimilarMoviesData {
  int? movieCount;
  List<MovieModel>? movies;

  SimilarMoviesData({this.movieCount, this.movies});

  SimilarMoviesData.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = <MovieModel>[];
      json['movies'].forEach((v) {
        movies!.add(MovieModel.fromJson(v));
      });
    }
  }
}
