import 'package:builder_bloc_template/core/config/api/api_service.dart';
import 'package:builder_bloc_template/core/config/api/api_config.dart';
import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/data/models/produk_model.dart';

abstract class ProdukDatasource {
  Future<BaseResponse<List<ProdukModel>>> fetchProduk();
}

class ProdukDatasourceImpl implements ProdukDatasource {
  final ApiService _apiService;

  const ProdukDatasourceImpl(this._apiService);

  @override
  Future<BaseResponse<List<ProdukModel>>> fetchProduk() async {
    final response = await _apiService.get(ApiConfig.getProdukPath);
    print("res $response");
    if(response.statusCode == 200) {
      final List jsonList = response.data;
      return SuccessResponse(jsonList.map((x) => ProdukModel.fromJson(x)).toList());
    } else {
      throw Exception("failed to fetch produk");
    }
  }
}