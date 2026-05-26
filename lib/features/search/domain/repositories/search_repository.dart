import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entites/search_movie_entity.dart';

abstract class SearchRepository{
  Future<Either<Failure, List<SearchMovieEntity>>> getMovies(String query, int page);
}
