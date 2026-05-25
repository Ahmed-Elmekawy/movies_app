import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:movies_app/features/home/domain/entites/home_movie_entity.dart';
import 'package:movies_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeMovieEntity>>> getAvailableNowMovies() async {
    try {
      final movies = await remoteDataSource.getAvailableNowMovies();
      return Right(movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeMovieEntity>>> getCategoryMovies(
    String genre,
  ) async {
    try {
      final movies = await remoteDataSource.getCategoryMovies(genre);
      return Right(movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
