import 'package:movies_app/core/utils/app_assets.dart';

import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String avatar;
  final List<int> watchList;
  final List<int> history;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.avatar = 'avatar1',
    required this.watchList,
    required this.history,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      watchList: List<int>.from(json['watch_list'] ?? []),
      history: List<int>.from(json['history'] ?? []),
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
    };
  }

  UserEntity toUserEntity() {
    return UserEntity(
      name: name,
      phone: phone,
      email: email,
      avatar: avatar,
      watchList: watchList,
      history: history,
    );
  }
}
