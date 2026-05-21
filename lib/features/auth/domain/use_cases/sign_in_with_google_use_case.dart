import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/auth/data/models/user_model.dart';
import 'package:movies_app/features/auth/domain/entities/user_entity.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_firebase_repository.dart';

class SignInWithGoogleUseCase {
  final AuthFirebaseRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await _repository.signInWithGoogle();
  }
}
