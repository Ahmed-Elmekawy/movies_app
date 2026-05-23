import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/auth_firebase_data_source.dart';
import '../../features/auth/data/data_sources/auth_firebase_data_source_impl.dart';
import '../../features/auth/data/repository_impl/auth_firebase_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_firebase_repository.dart';
import '../../features/auth/domain/use_cases/check_auth_status_use_case.dart';
import '../../features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import '../../features/auth/domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import '../../features/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import '../../features/auth/domain/use_cases/sign_out_use_case.dart';
import '../../features/auth/domain/use_cases/sign_up_with_email_and_password_use_case.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../utils/cache_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SendPasswordResetEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthFirebaseRepository>(
    () => AuthFirebaseRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(sl(), sl(), sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => CacheHelper(sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
}
