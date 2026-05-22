import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/core/di/injection_container.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // Add a slight delay to show the splash logo
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.read<AuthCubit>().checkAuthStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.profile);
        } else if (state is Unauthenticated) {
          final prefs = sl<SharedPreferences>();
          final bool isFirstTime = prefs.getBool(CacheConstants.onBoardingKey) ?? true;

          if (isFirstTime) {
            Navigator.pushReplacementNamed(context, AppRoutes.onBoardingScreen);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
          }
        }
      },
      child: const Scaffold(
        body: SplashContent(),
      ),
    );
  }
}
