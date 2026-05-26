import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
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
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/data_sources/home_remote_data_source_impl.dart';
import '../../features/home/data/repository_impl/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/use_cases/get_available_now_movies_use_case.dart';
import '../../features/home/domain/use_cases/get_category_movies_use_case.dart';
import '../../features/home/presentation/bloc/home_cubit.dart';
import '../../features/movie_details/data/data_sources/movie_details_remote_data_source.dart';
import '../../features/movie_details/data/data_sources/movie_details_remote_data_source_impl.dart';
import '../../features/movie_details/data/repository_impl/movie_details_repository_impl.dart';
import '../../features/movie_details/domain/repositories/movie_details_repository.dart';
import '../../features/movie_details/domain/use_cases/get_movie_details_use_case.dart';
import '../../features/movie_details/domain/use_cases/get_similar_movies_use_case.dart';
import '../../features/movie_details/presentations/bloc/movie_details_cubit.dart';
import '../../features/search/data/data_sources/search_remote_data_source.dart';
import '../../features/search/data/data_sources/search_remote_data_source_impl.dart';
import '../../features/search/data/repository_impl/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/domain/use_cases/get_search_movies_use_case.dart';
import '../../features/search/presentation/bloc/search_cubit.dart';
import '../constants/app_constants.dart';
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

  // Features - Home
  // Cubit
  sl.registerFactory(() => HomeCubit(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAvailableNowMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoryMoviesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );

  // Features - Movie Details
  // Cubit
  sl.registerFactory(() => MovieDetailsCubit(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetSimilarMoviesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<MovieDetailsRepository>(
    () => MovieDetailsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
    () => MovieDetailsRemoteDataSourceImpl(sl()),
  );

  // Features - Search
  // Cubit
  sl.registerFactory(() => SearchCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetSearchMoviesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => CacheHelper(sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn.instance);
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    ),
  );
}
