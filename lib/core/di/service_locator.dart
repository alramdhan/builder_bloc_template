import 'package:builder_bloc_template/core/config/api/api_service.dart';
import 'package:builder_bloc_template/core/config/api/api_config.dart';
import 'package:builder_bloc_template/core/config/api/log_interceptor.dart';
import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/data/datasources/auth_datasource.dart';
import 'package:builder_bloc_template/data/datasources/produk_datasource.dart';
import 'package:builder_bloc_template/data/repositories/auth_repository.dart';
import 'package:builder_bloc_template/data/repositories/produk_repository.dart';
import 'package:builder_bloc_template/domain/repositories/auth_repository.dart';
import 'package:builder_bloc_template/domain/repositories/produk_repository.dart';
import 'package:builder_bloc_template/domain/usecases/auth_usecase.dart';
import 'package:builder_bloc_template/domain/usecases/get_cart_usecase.dart';
import 'package:builder_bloc_template/domain/usecases/get_products_usecase.dart';
import 'package:builder_bloc_template/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:builder_bloc_template/presentation/views/home/bloc/cart/cart_bloc.dart';
import 'package:builder_bloc_template/presentation/views/home/bloc/produk/produk_bloc.dart';
import 'package:builder_bloc_template/presentation/views/home/cubit/menutab_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final sl = GetIt.instance;

void serviceLocatorSetup() {
  // log for debugging from Logger package
  sl.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.dateAndTime
      )
    )
  );

  // dio locator and ApiService
  sl.registerLazySingleton<Dio>(() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(CustomLogInterceptor());

    return dio;
  });
  sl.registerLazySingleton(() => ApiService(sl()));

  sl.registerLazySingleton(() => MenutabCubit());

  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerFactory(() => AuthBloc(useCase: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AuthUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(sl()));

  // produk
  sl.registerFactory(() => ProdukBloc(sl()));
  sl.registerLazySingleton<ProdukRepository>(() => ProdukRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetProductsUsecase(produkRepository: sl()));
  sl.registerLazySingleton<ProdukDatasource>(() => ProdukDatasourceImpl(sl()));
  //cart
  sl.registerFactory(() => CartBloc(sl()));
  sl.registerLazySingleton(() => GetCartUsecase(produkRepository: sl()));
}