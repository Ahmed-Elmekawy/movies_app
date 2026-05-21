import '../models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<UserModel> signInWithGoogle();
}
