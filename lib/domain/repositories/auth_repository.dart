import 'package:builder_bloc_template/core/config/error/failure.dart';
import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<Failure, UserEntity>> login(
    String email,
    String password
  );
}