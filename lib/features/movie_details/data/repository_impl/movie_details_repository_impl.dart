import 'package:dartz/dartz.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../data_sources/movie_details_remote_data_source.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(int movieId) async {
    try {
      final movie = await remoteDataSource.getMovieDetails(movieId);
      return Right(movie.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(int movieId) async {
    try {
      final movies = await remoteDataSource.getSimilarMovies(movieId);
      return Right(movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
