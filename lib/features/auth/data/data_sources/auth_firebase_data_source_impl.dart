import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/features/auth/data/data_sources/auth_firebase_data_source.dart';
import '../models/user_model.dart';

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthFirebaseDataSourceImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._firestore,
  );

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      _googleSignIn.initialize(serverClientId: '570232457456-1pft4rjlpf6omrdbdeo3cafp6a0b08ca.apps.googleusercontent.com');
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();


      final GoogleSignInAuthentication googleAuth =
           googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('User is null after sign in');
      }

      UserModel? userModel = await _getFromFireStore(user.uid);

      if (userModel == null) {
        userModel = UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          phone: user.phoneNumber ?? '',
          email: user.email ?? '',
          avatar: user.photoURL ?? '',
          watchList: [],
          history: [],
        );
        await _addToFireStore(userModel);
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } on GoogleSignInException catch (e) {
      throw Exception(_handleGoogleSignInException(e));
    } catch (e) {
      throw Exception('An unknown error occurred during Google sign-in: $e');
    }
  }

  Future<UserModel?> _getFromFireStore(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> _addToFireStore(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }
}


String _handleAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'network-request-failed':
      return 'Network error, Please check your connection.';
    case 'user-not-found':
      return 'No user found for that email.';
    case 'wrong-password':
      return 'Wrong password provided for that user.';
    case 'email-already-in-use':
      return 'The account already exists for that email.';
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'weak-password':
      return 'The password provided is too weak.';
    case 'user-disabled':
      return 'This user has been disabled.';
    case 'too-many-requests':
      return 'Too many requests. Try again later.';
    case 'operation-not-allowed':
      return 'This operation is not allowed.';
    case 'invalid-credential':
      return 'Invalid credentials, please try again.';
    case 'account-exists-with-different-credential':
      return 'An account already exists with the same email address but different sign-in credentials.';
    default:
      return e.message ?? 'Authentication error occurred.';
  }
}

String _handleGoogleSignInException(GoogleSignInException e) {
  switch (e.code) {
    case GoogleSignInExceptionCode.canceled:
      return 'Sign-in canceled.';
    default:
      return 'Google sign-in failed.';
  }
}
