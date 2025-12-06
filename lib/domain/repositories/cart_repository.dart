import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/cart.dart';

abstract class CartRepository {
  Future<BaseResponse<Cart>> getProduks();
}