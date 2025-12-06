import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/cart.dart';
import 'package:builder_bloc_template/domain/repositories/produk_repository.dart';

class GetCartUsecase {
  final ProdukRepository produkRepository;

  GetCartUsecase({required this.produkRepository});

  Future<BaseResponse<Cart>> call() async {
    return await produkRepository.getCarts();
  }
}