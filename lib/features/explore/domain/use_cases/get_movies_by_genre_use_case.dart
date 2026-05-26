import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/explore_movie_entity.dart';
import '../repositories/explore_repository.dart';

class GetMoviesByGenreUseCase {
  final ExploreRepository repository;

  GetMoviesByGenreUseCase(this.repository);

  Future<Either<Failure, List<ExploreMovieEntity>>> call(String genre, int page) async {
    return await repository.getMoviesByGenre(genre, page);
  }
}
