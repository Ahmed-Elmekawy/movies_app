import 'package:movies_app/features/home/data/models/home_movie_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeMovieModel>> getAvailableNowMovies();
  Future<List<HomeMovieModel>> getCategoryMovies(String genre);
}
