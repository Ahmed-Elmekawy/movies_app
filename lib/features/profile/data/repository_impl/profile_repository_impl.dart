import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/data/models/movie_model.dart';
import '../../../auth/domain/entities/movie_entity.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    try {
      final userModel = await _remoteDataSource.updateProfile(
        name: name,
        phone: phone,
        avatar: avatar,
      );
      return Right(userModel.toUserEntity());
    } on RemoteException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> addToWatchList(MovieEntity movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        rating: movie.rating,
        mediumCoverImage: movie.mediumCoverImage,
      );
      final userModel = await _remoteDataSource.addToWatchList(movieModel);
      return Right(userModel.toUserEntity());
    } on RemoteException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> addToHistory(MovieEntity movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        rating: movie.rating,
        mediumCoverImage: movie.mediumCoverImage,
      );
      final userModel = await _remoteDataSource.addToHistory(movieModel);
      return Right(userModel.toUserEntity());
    } on RemoteException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
