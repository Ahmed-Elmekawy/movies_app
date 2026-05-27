import 'package:movies_app/core/utils/app_assets.dart';

abstract class AppConstants {
  static const List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

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
}

abstract class ApiConstants {
  static const String baseUrl = 'https://movies-api.accel.li/api/v2/';
  static const String movieDetails = 'movie_details.json';
  static const String movieSuggestions = 'movie_suggestions.json';
  static const String listMovies = 'list_movies.json';
}

abstract class CacheConstants {
  static const String onBoardingKey = "onBoarding";
  static const String localeKey = "locale";
}

abstract class FirebaseConstants {
  static const String usersCollection = 'users';
}
