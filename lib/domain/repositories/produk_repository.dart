import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/produk.dart';

abstract class ProdukRepository {
  Future<BaseResponse<List<Produk>>> getProduks();
}