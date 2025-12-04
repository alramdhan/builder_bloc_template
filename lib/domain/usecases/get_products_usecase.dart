import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/produk.dart';
import 'package:builder_bloc_template/domain/repositories/produk_repository.dart';

class GetProductsUsecase {
  final ProdukRepository produkRepository;

  GetProductsUsecase({required this.produkRepository});

  Future<BaseResponse<List<Produk>>> call() async {
    return await produkRepository.getProduks();
  }
}