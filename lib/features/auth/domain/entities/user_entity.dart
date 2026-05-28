import 'movie_entity.dart';

class UserEntity {
  final String name;
  final String phone;
  final String email;
  final String avatar;
  final List<MovieEntity> watchList;
  final List<MovieEntity> history;

  UserEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.watchList,
    required this.history,
  });
}
