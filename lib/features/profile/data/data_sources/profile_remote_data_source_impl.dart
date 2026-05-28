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

  CollectionReference<UserModel> get _usersCollection =>
      _firestore.collection(FirebaseConstants.usersCollection).withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

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
      if (name != null) updates[FirebaseConstants.name] = name;
      if (phone != null) updates[FirebaseConstants.phone] = phone;
      if (avatar != null) updates[FirebaseConstants.avatar] = avatar;

      if (updates.isNotEmpty) {
        await _usersCollection.doc(user.uid).update(updates);
      }

      final doc = await _usersCollection.doc(user.uid).get();
      return doc.data()!;
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

      final userRef = _usersCollection.doc(user.uid);
      final doc = await userRef.get();
      final userModel = doc.data();
      
      if (userModel == null) throw RemoteException('User not found');

      final List<MovieModel> watchList = List.from(userModel.watchList);
      watchList.removeWhere((item) => item.id == movie.id);
      watchList.add(movie);

      await userRef.update({FirebaseConstants.watchList: watchList.map((e) => e.toJson()).toList()});

      final updatedDoc = await userRef.get();
      return updatedDoc.data()!;
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

      final userRef = _usersCollection.doc(user.uid);
      final doc = await userRef.get();
      final userModel = doc.data();
      
      if (userModel == null) throw RemoteException('User not found');
      
      final List<MovieModel> history = List.from(userModel.history);

      history.removeWhere((item) => item.id == movie.id);
      history.add(movie);

      await userRef.update({FirebaseConstants.history: history.map((e) => e.toJson()).toList()});

      final updatedDoc = await userRef.get();
      return updatedDoc.data()!;
    } on FirebaseException catch (e) {
      throw RemoteException(e.message ?? 'Failed to add to history');
    } catch (e) {
      throw RemoteException(e.toString());
    }
  }
}
