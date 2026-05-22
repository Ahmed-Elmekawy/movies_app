import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_firebase_repository.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthFirebaseRepository repository;

  SignUpWithEmailAndPasswordUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
  }) {
    return repository.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
      phone: phone,
      avatar: avatar,
    );
  }
}
