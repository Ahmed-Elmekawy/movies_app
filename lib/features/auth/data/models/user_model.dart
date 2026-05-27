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
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatar: json['avatar'] as String? ?? 'avatar1',
      watchList: (json['watch_list'] as List? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      history: (json['history'] as List? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'avatar': avatar,
      'watch_list': watchList.map((movie) => movie.toJson()).toList(),
      'history': history.map((movie) => movie.toJson()).toList(),
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
