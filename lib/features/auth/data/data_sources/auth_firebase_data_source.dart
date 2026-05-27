import '../models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
  });
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<UserModel?> checkAuthStatus();
  Future<void> deleteAccount(String password);
  Future<void> updatePassword({required String oldPassword, required String newPassword});
}
