import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entites/home_movie_entity.dart';
import '../repositories/home_repository.dart';

class GetAvailableNowMoviesUseCase {
  final HomeRepository repository;

  GetAvailableNowMoviesUseCase(this.repository);

  Future<Either<Failure, List<HomeMovieEntity>>> call() {
    return repository.getAvailableNowMovies();
  }
}
