import '../models/search_movie_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchMovieModel>> getMovies(String query, int page);
}
