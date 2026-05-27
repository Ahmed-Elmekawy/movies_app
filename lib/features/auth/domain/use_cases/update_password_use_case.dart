import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_firebase_repository.dart';

class UpdatePasswordUseCase {
  final AuthFirebaseRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String oldPassword,
    required String newPassword,
  }) {
    return repository.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
