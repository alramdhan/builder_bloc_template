import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/data/datasources/auth_datasource.dart';
import 'package:builder_bloc_template/data/repositories/auth_repository.dart';
import 'package:builder_bloc_template/domain/repositories/auth_repository.dart';
import 'package:builder_bloc_template/domain/usecases/auth_usecase.dart';
import 'package:builder_bloc_template/firebase_options.dart';
import 'package:builder_bloc_template/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void serviceLocatorSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerFactory(() => AuthBloc(useCase: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AuthUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(sl()));
}