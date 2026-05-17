import 'package:flutter/material.dart';
import '../../features/profile/presentations/views/screens/profile_screen.dart';
import '../../features/profile/presentations/views/screens/edit_profile_screen.dart';

abstract class AppRoutes {
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  static Map<String, WidgetBuilder> get routes => {
        profile: (context) => const ProfileScreen(),
        editProfile: (context) => const EditProfileScreen(),
      };
}
