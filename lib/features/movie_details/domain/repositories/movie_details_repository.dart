import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, MovieEntity>> getMovieDetails(int movieId);
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(int movieId);
}
