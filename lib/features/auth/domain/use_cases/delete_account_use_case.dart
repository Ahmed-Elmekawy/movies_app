import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_firebase_repository.dart';

class DeleteAccountUseCase {
  final AuthFirebaseRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure, void>> call(String password) {
    return repository.deleteAccount(password);
  }
}
