import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/user_entity.dart';
import 'movie_model.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String avatar;
  final List<MovieModel> watchList;
  final List<MovieModel> history;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.watchList,
    required this.history,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[FirebaseConstants.id] as String? ?? '',
      name: json[FirebaseConstants.name] as String? ?? '',
      phone: json[FirebaseConstants.phone] as String? ?? '',
      email: json[FirebaseConstants.email] as String? ?? '',
      avatar: json[FirebaseConstants.avatar] as String? ?? 'avatar1',
      watchList: (json[FirebaseConstants.watchList] as List? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      history: (json[FirebaseConstants.history] as List? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirebaseConstants.id: id,
      FirebaseConstants.name: name,
      FirebaseConstants.phone: phone,
      FirebaseConstants.email: email,
      FirebaseConstants.avatar: avatar,
      FirebaseConstants.watchList: watchList.map((movie) => movie.toJson()).toList(),
      FirebaseConstants.history: history.map((movie) => movie.toJson()).toList(),
    };
  }

  UserEntity toUserEntity() {
    return UserEntity(
      name: name,
      phone: phone,
      email: email,
      avatar: avatar,
      watchList: watchList.map((movie) => movie.toEntity()).toList(),
      history: history.map((movie) => movie.toEntity()).toList(),
    );
  }
}
