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
  final int wishlist;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.avatar = 'avatar1',
    required this.watchList,
    required this.history,
    this.wishlist = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      watchList: List<MovieModel>.from(json['watch_list'] ?? []),
      history: List<MovieModel>.from(json['history'] ?? []),
      wishlist: json['wishlist'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'avatar': avatar,
      'watch_list': watchList,
      'history': history,
      'wishlist': wishlist,
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
      wishlist: wishlist,
    );
  }
}
