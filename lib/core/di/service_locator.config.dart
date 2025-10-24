// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:builder_bloc_template/core/config/router.dart' as _i3;
import 'package:builder_bloc_template/core/di/service_locator.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final applicationRouterModule = _$ApplicationRouterModule();
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.singleton<_i3.AppRouter>(() => applicationRouterModule.router);
    gh.lazySingleton<_i4.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    return this;
  }
}

class _$ApplicationRouterModule extends _i5.ApplicationRouterModule {}

class _$FirebaseInjectableModule extends _i5.FirebaseInjectableModule {}
