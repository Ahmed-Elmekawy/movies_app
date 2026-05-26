import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/explore_movie_entity.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<ExploreMovieEntity>>> getMoviesByGenre(String genre, int page);
}
