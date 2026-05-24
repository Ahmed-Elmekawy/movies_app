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
}

abstract class RemoteConstants {
  static const String baseUrl = 'https://movies-api.accel.li/api/v2/';
  static const String movieDetails = 'movie_details.json';
  static const String movieSuggestions = 'movie_suggestions.json';
}

abstract class CacheConstants {
  static const String onBoardingKey = "onBoarding";
}

abstract class FirebaseConstants {
  static const String usersCollection = 'users';
}
