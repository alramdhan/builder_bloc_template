import 'package:builder_bloc_template/data/models/produk_model.dart';
import 'package:builder_bloc_template/domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel({required super.id, required super.userId, required super.products});
  
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'],
    userId: json['userId'],
    products: List.from(json['products'].map((e) => ProdukModel.fromJson(e)))
  );
}