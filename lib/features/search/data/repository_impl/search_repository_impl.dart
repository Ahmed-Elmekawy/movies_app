import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/search/domain/entites/search_movie_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SearchMovieEntity>>> getMovies(
    String query,
    int page,
  ) async {
    try {
      final movies = await remoteDataSource.getMovies(query, page);
      return Right(movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch search results'));
    }
  }
}
