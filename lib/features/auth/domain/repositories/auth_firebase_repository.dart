import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthFirebaseRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
