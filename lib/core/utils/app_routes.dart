import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/presentation/views/login/screens/login_screen.dart';
import 'package:movies_app/features/splash/presentation/views/screens/splash_screen.dart';
import '../../features/auth/presentation/views/forgot_password/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/views/register/screens/register_screen.dart';
import '../../features/onboarding/screen/on_boarding_screen.dart';
import '../../features/profile/presentation/views/screens/profile_screen.dart';
import '../../features/profile/presentation/views/screens/edit_profile_screen.dart';
import '../../features/movie_details/presentations/views/screens/movie_details_screen.dart';
import '../../features/home/presentation/views/screens/home_screen.dart';
import '../../features/profile/presentation/views/screens/reset_password_screen.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String movieDetails = '/movie-details';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String onBoardingScreen = '/onboardingScreen';
  static const String resetPassword = '/resetPassword';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    movieDetails: (context) => const MovieDetailsScreen(),
    onBoardingScreen: (context) => const OnBoardingScreen(),
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    profile: (context) => const ProfileScreen(),
    editProfile: (context) => const EditProfileScreen(),
    resetPassword: (context) => const ResetPasswordScreen(),
  };
}
