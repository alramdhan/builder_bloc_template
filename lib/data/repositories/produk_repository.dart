import 'package:builder_bloc_template/data/datasources/produk_datasource.dart';
import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/produk.dart';
import 'package:builder_bloc_template/domain/repositories/produk_repository.dart';

class ProdukRepositoryImpl implements ProdukRepository {
  final ProdukDatasource dataSource;

  const ProdukRepositoryImpl(this.dataSource);

  @override
  Future<BaseResponse<List<Produk>>> getProduks() async {
    return await dataSource.fetchProduk();
  }
}