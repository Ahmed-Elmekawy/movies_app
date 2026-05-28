import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/movie_entity.dart';
import '../../../auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  });

  Future<Either<Failure, UserEntity>> addToWatchList(MovieEntity movie);
  Future<Either<Failure, UserEntity>> addToHistory(MovieEntity movie);
}
