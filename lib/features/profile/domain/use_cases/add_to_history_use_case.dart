import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/movie_entity.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class AddToHistoryUseCase {
  final ProfileRepository repository;

  AddToHistoryUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(MovieEntity movie) {
    return repository.addToHistory(movie);
  }
}
