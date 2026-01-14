import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodbrew/features/auth/domain/usecases/reset_password.dart';
import 'package:moodbrew/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:moodbrew/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Data sources
import 'features/recommendation/data/datasources/drinks_local_data_source.dart';
import 'features/recommendation/data/datasources/recommendation_engine.dart';
import 'features/reflection/data/datasources/reflection_generator.dart';
import 'features/auth/data/datasources/auth_firebase_data_source.dart';
import 'features/moments/data/datasources/moments_firebase_data_source.dart';

// Repositories
import 'features/recommendation/domain/repositories/recommendation_repository.dart';
import 'features/recommendation/data/repositories/recommendation_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/moments/domain/repositories/moments_repository.dart';
import 'features/moments/data/repositories/moments_repository_impl.dart';

// Use cases
import 'features/recommendation/domain/usecases/get_recommendation.dart';
import 'features/moments/domain/usecases/save_moment.dart';
import 'features/moments/domain/usecases/get_moments.dart';
import 'features/auth/domain/usecases/sign_in_with_google.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ========== Use Cases ==========
  sl.registerLazySingleton(() => GetRecommendation(sl()));
  sl.registerLazySingleton(() => SaveMoment(sl()));
  sl.registerLazySingleton(() => GetMoments(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));

  // ========== Repositories ==========
  sl.registerLazySingleton<RecommendationRepository>(
    () => RecommendationRepositoryImpl(
      drinksDataSource: sl(),
      engine: sl(),
      reflectionGenerator: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<MomentsRepository>(
    () => MomentsRepositoryImpl(dataSource: sl()),
  );

  // ========== Data Sources ==========
  sl.registerLazySingleton<DrinksLocalDataSource>(
    () => DrinksLocalDataSourceImpl(),
  );

  sl.registerLazySingleton(() => ReflectionGenerator());

  sl.registerLazySingleton<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(auth: sl()),
  );

  sl.registerLazySingleton<MomentsFirebaseDataSource>(
    () => MomentsFirebaseDataSourceImpl(firestore: sl()),
  );

  // ========== Core ==========
  sl.registerLazySingleton<RecommendationEngine>(() {
    final drinks = sl<DrinksLocalDataSource>().getDrinks();
    return RecommendationEngine(drinks);
  });

  // ========== External ==========
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
