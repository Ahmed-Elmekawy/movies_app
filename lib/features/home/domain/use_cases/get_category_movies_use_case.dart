import 'package:dartz/dartz.dart';
import 'package:movies_app/features/home/domain/repositories/home_repository.dart';
import '../../../../core/errors/failures.dart';
import '../entites/home_movie_entity.dart';

class GetCategoryMoviesUseCase {
  final HomeRepository repository;

  GetCategoryMoviesUseCase(this.repository);

  Future<Either<Failure, List<HomeMovieEntity>>> call(String genre) {
    return repository.getCategoryMovies(genre);
  }
}
