import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/user_entity.dart';
import 'package:builder_bloc_template/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<BaseResponse<UserEntity>> call(String email, String password, {bool isLogin = true}) async {
    if(!email.contains('@')) return const FailureResponse(ErrorResponse(message: "Email tidak valid"));

    return isLogin ? authRepository.login(email, password) : authRepository.registrasi(email, password);
  }
}