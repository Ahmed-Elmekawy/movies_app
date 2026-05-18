import 'package:flutter/material.dart';
import '../../features/onboarding/screen/on_boarding_screen.dart';
import '../../features/login/screen/login_screen.dart';
import '../../features/profile/presentations/views/screens/profile_screen.dart';
import '../../features/profile/presentations/views/screens/edit_profile_screen.dart';
import '../../features/movie_details/presentations/views/screens/movie_details_screen.dart';

abstract class AppRoutes {
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String movieDetails = '/movie-details';
  static const String loginScreen = '/loginScreen';
  static const String onBoardingScreen = '/onboardingScreen';

  static Map<String, WidgetBuilder> get routes => {
    movieDetails: (context) => const MovieDetailsScreen(),
    onBoardingScreen: (context) => const OnBoardingScreen(),
    loginScreen: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
    editProfile: (context) => const EditProfileScreen(),
  };
}
