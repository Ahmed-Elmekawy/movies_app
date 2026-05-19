import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'core/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {

  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = di.sl<SharedPreferences>();
    final bool showOnBoarding = prefs.getBool(CacheConstants.onBoardingKey) ?? true;
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: showOnBoarding? AppRoutes.onBoardingScreen : AppRoutes.loginScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
