import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_details_repository.dart';

class GetSimilarMoviesUseCase {
  final MovieDetailsRepository repository;

  GetSimilarMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call(int movieId) async {
    return await repository.getSimilarMovies(movieId);
  }
}
