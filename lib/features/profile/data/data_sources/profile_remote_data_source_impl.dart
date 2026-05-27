import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../auth/data/models/movie_model.dart';
import '../../../auth/data/models/user_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw RemoteException('No user logged in');

      final Map<String, dynamic> updates = {};
      if (name != null) updates['name'] = name;
      if (phone != null) updates['phone'] = phone;
      if (avatar != null) updates['avatar'] = avatar;

      if (updates.isNotEmpty) {
        await _firestore.collection(FirebaseConstants.usersCollection).doc(user.uid).update(updates);
      }

      final doc = await _firestore.collection(FirebaseConstants.usersCollection).doc(user.uid).get();
      return UserModel.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw RemoteException(e.message ?? 'Failed to update profile');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }

  @override
  Future<UserModel> addToWatchList(MovieModel movie) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw RemoteException('No user logged in');

      final userRef = _firestore.collection(FirebaseConstants.usersCollection).doc(user.uid);
      final doc = await userRef.get();
      final data = doc.data() ?? {};
      
      List watchList = List.from(data['watch_list'] ?? []);
      watchList.removeWhere((item) => item['id'] == movie.id);
      watchList.add(movie.toJson());

      await userRef.update({'watch_list': watchList});

      final updatedDoc = await userRef.get();
      return UserModel.fromJson(updatedDoc.data()!);
    } on FirebaseException catch (e) {
      throw RemoteException(e.message ?? 'Failed to add to watchlist');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }

  @override
  Future<UserModel> addToHistory(MovieModel movie) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw RemoteException('No user logged in');

      final userRef = _firestore.collection(FirebaseConstants.usersCollection).doc(user.uid);
      final doc = await userRef.get();
      final data = doc.data() ?? {};
      
      List history = List.from(data['history'] ?? []);

      history.removeWhere((item) => item['id'] == movie.id);
      history.add(movie.toJson());

      await userRef.update({'history': history});

      final updatedDoc = await userRef.get();
      return UserModel.fromJson(updatedDoc.data()!);
    } on FirebaseException catch (e) {
      throw RemoteException(e.message ?? 'Failed to add to history');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }
}
