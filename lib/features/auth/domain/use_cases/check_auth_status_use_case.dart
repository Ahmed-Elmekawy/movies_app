import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_firebase_repository.dart';

class CheckAuthStatusUseCase {
  final AuthFirebaseRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<Either<Failure, UserEntity?>> call() {
    return repository.checkAuthStatus();
  }
}
