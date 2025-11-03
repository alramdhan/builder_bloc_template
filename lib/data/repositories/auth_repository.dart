import 'package:builder_bloc_template/core/config/error/exception.dart';
import 'package:builder_bloc_template/core/config/error/failure.dart';
import 'package:builder_bloc_template/data/datasources/auth_datasource.dart';
import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/user_entity.dart';
import 'package:builder_bloc_template/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<BaseResponse<Failure, UserEntity>> login(String email, String password) async {
    try {
      final userModel = await authDatasource.login(email, password);

      return BaseResponse(success: true, data: userModel);
    } on ServerException {
      return const BaseResponse(success: false, message: 'Login Gagal');
    }
  }
}