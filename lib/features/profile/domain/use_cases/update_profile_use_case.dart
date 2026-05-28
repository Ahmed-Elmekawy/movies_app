import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    String? name,
    String? phone,
    String? avatar,
  }) {
    return repository.updateProfile(
      name: name,
      phone: phone,
      avatar: avatar,
    );
  }
}
