import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_firebase_repository.dart';

class SendPasswordResetEmailUseCase {
  final AuthFirebaseRepository repository;

  SendPasswordResetEmailUseCase(this.repository);

  Future<Either<Failure, void>> call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}
