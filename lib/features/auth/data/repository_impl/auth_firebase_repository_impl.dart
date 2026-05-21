import 'package:dartz/dartz.dart';
import 'package:movies_app/features/auth/data/data_sources/auth_firebase_data_source.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_firebase_repository.dart';

class AuthFirebaseRepositoryImpl implements AuthFirebaseRepository {
  final AuthFirebaseDataSource _authFirebaseDataSource;

  AuthFirebaseRepositoryImpl(this._authFirebaseDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await _authFirebaseDataSource.signInWithGoogle();
      return Right(userModel.toUserEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
