import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/core/di/service_locator.config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final sl = GetIt.instance;

@InjectableInit()
void configureDependencies() => sl.init();

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}

@module
abstract class ApplicationRouterModule {
  @singleton
  AppRouter get router => AppRouter();
}

// void serviceLocatorSetup() {
//   sl.registerLazySingleton(() => AppRouter());
//   sl.registerLazySingleton(() => FirebaseAuth.instance);
// }