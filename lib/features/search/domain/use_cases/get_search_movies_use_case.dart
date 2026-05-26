import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entites/search_movie_entity.dart';
import '../repositories/search_repository.dart';

class GetSearchMoviesUseCase {
  final SearchRepository repository;

  GetSearchMoviesUseCase(this.repository);

  Future<Either<Failure, List<SearchMovieEntity>>> call(String query, int page) async {
    return await repository.getMovies(query, page);
  }
}
