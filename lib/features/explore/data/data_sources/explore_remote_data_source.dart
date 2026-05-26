import '../models/explore_movie_model.dart';

abstract class ExploreRemoteDataSource {
  Future<List<ExploreMovieModel>> getMoviesByGenre(String genre, int page);
}
