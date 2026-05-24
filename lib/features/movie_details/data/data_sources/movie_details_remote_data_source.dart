import '../models/movie_model.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> getSimilarMovies(int movieId);
}
