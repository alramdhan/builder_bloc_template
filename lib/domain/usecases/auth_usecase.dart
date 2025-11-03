import 'package:builder_bloc_template/core/config/error/failure.dart';
import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/user_entity.dart';
import 'package:builder_bloc_template/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<BaseResponse<Failure, UserEntity>> call(String email, String password) async {
    if(!email.contains('@')) return const BaseResponse(success: false, message: "Email tidak valid");

    return authRepository.login(email, password);
  }
}