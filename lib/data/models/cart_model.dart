import 'package:builder_bloc_template/domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel({required super.id, required super.userId, required super.products});
  
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'],
    userId: json['userId'],
    products: List.from(json['products'].map((e) => Produk.fromJson(e)))
  );
}

class Produk {
  final int productId;
  final int quantity;

  const Produk({
    required this.productId,
    required this.quantity
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    productId: json['productId'],
    quantity: json['quantity']
  );
}