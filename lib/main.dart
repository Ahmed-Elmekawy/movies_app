import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:movies_app/firebase_options.dart';
import 'core/config/theme/app_theme.dart';
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
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => BlocProvider(
        create: (context) => di.sl<AuthCubit>(),
        child: MaterialApp(
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: (settings) {
            final WidgetBuilder? builder = AppRoutes.routes[settings.name];
            if (builder != null) {
              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (context, animation, secondaryAnimation) => builder(context),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
