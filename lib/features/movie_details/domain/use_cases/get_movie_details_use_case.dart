import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_details_repository.dart';

class GetMovieDetailsUseCase {
  final MovieDetailsRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<Either<Failure, MovieEntity>> call(int movieId) async {
    return await repository.getMovieDetails(movieId);
  }
}
