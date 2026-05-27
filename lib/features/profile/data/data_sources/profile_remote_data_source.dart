import '../../../auth/data/models/movie_model.dart';
import '../../../auth/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  });

  Future<UserModel> addToWatchList(MovieModel movie);
  Future<UserModel> addToHistory(MovieModel movie);
}
