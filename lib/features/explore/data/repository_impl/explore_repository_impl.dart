import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/explore_movie_entity.dart';
import '../../domain/repositories/explore_repository.dart';
import '../data_sources/explore_remote_data_source.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource remoteDataSource;

  ExploreRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ExploreMovieEntity>>> getMoviesByGenre(
      String genre, int page) async {
    try {
      final movies = await remoteDataSource.getMoviesByGenre(genre, page);
      return Right(movies.map((movie) => movie.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
