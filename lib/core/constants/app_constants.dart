import 'package:movies_app/core/utils/app_assets.dart';

abstract class AppConstants {
  static const Map<String, String> avatarMap = {
    'avatar1': AppImages.avatar1,
    'avatar2': AppImages.avatar2,
    'avatar3': AppImages.avatar3,
    'avatar4': AppImages.avatar4,
    'avatar5': AppImages.avatar5,
    'avatar6': AppImages.avatar6,
    'avatar7': AppImages.avatar7,
    'avatar8': AppImages.avatar8,
    'avatar9': AppImages.avatar9,
  };

  static List<String> get avatarKeys => avatarMap.keys.toList();

  static String getAvatarPath(String? key) => avatarMap[key] ?? AppImages.avatar1;

  static const List<String> genres = [
    'Action',
    'War',
    'Adventure',
    'Animation',
    'Anime',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Game Show',
    'Horror',
    'History',
    'Language',
    'Lifestyle',
    'Music',
    'Musical',
    'Mystery',
    'Reality TV',
    'Romance',
    'Sci-Fi',
    'Seasonal',
    'Sport',
    'Thriller',
    'Western',
  ];

  static const String defaultAvatar = 'avatar1';
}

abstract class ApiConstants {
  static const String baseUrl = 'https://movies-api.accel.li/api/v2/';
  static const String movieDetails = 'movie_details.json';
  static const String movieSuggestions = 'movie_suggestions.json';
  static const String listMovies = 'list_movies.json';
  
  static const String serverClientId = "570232457456-1pft4rjlpf6omrdbdeo3cafp6a0b08ca.apps.googleusercontent.com";
}

abstract class CacheConstants {
  static const String onBoardingKey = "onBoarding";
}

abstract class FirebaseConstants {
  static const String usersCollection = 'users';
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String watchList = 'watch_list';
  static const String history = 'history';
  static const String rating = 'rating';
  static const String mediumCoverImage = 'medium_cover_image';
}
