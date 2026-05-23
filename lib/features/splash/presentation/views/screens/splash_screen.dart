import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/core/di/injection_container.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/cache_helper.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_state.dart';
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
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is Unauthenticated) {
          final cacheHelper = sl<CacheHelper>();
          final bool isFirstTime = cacheHelper.getBool(key: CacheConstants.onBoardingKey) ?? true;

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
