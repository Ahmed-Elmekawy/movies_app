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
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();


      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
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
          watchList: [],
          history: [],
        );
        await _addToFireStore(userModel);
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An unknown error occurred during Google sign-in: $e');
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('User is null after sign in');
      }

      UserModel? userModel = await _getFromFireStore(user.uid);
      if (userModel == null) {
        throw Exception('User data not found in Firestore');
      }
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An unknown error occurred during sign-in: $e');
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('User is null after sign up');
      }

      final userModel = UserModel(
        id: user.uid,
        name: name,
        email: email,
        phone: phone,
        avatar: avatar,
        watchList: [],
        history: [],
      );

      await _addToFireStore(userModel);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An unknown error occurred during sign-up: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An error occurred while sending reset email: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
        await _googleSignIn.signOut();

      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('An error occurred during sign-out: $e');
    }
  }

  @override
  Future<UserModel?> checkAuthStatus() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        final userModel = await _getFromFireStore(user.uid);
        if (userModel == null) {
          await signOut();
          return null;
        }
        return userModel;
      }
      return null;
    } catch (e) {
      throw Exception('An error occurred while checking auth status: $e');
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
