import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<UserEntity>> login(
    String email,
    String password
  );
  Future<BaseResponse<UserEntity>> registrasi(
    String email,
    String password
  );
}