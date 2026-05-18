import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;
  final String? description;
  final Color gradientColor;

  const OnBoardingModel({
    required this.imagePath,
    required this.title,
    this.description,
    required this.gradientColor,
  });

  static List<OnBoardingModel> onBoardingList = [
    const OnBoardingModel(
      imagePath: AppImages.onboarding1,
      title: "Find Your Next\nFavorite Movie Here",
      description: "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      gradientColor: Colors.black,
    ),
    const OnBoardingModel(
      imagePath: AppImages.onboarding2,
      title: "Discover Movies",
      description: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      gradientColor: Color(0xFF003D4C), // Teal/Blue from image
    ),
    const OnBoardingModel(
      imagePath: AppImages.onboarding3,
      title: "Explore All Genres",
      description: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      gradientColor: Color(0xFF6C1212), // Deep Red from image
    ),
    const OnBoardingModel(
      imagePath: AppImages.onboarding4,
      title: "Create Watchlists",
      description: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      gradientColor: Color(0xFF4C004C), // Purple from image
    ),
    const OnBoardingModel(
      imagePath: AppImages.onboarding5,
      title: "Rate, Review, and Learn",
      description: "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      gradientColor: Color(0xFF5A0000), // Dark Red from image
    ),
    const OnBoardingModel(
      imagePath: AppImages.onboarding6,
      title: "Start Watching Now",
      description: null,
      gradientColor: Colors.black,
    ),
  ];
}
