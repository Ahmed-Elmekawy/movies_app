import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_firebase_repository.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthFirebaseRepository repository;

  SignInWithEmailAndPasswordUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}
