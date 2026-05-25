import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entites/home_movie_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeMovieEntity>>> getAvailableNowMovies();
  Future<Either<Failure, List<HomeMovieEntity>>> getCategoryMovies(String genre);
}
