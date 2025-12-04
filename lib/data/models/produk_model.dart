import 'package:builder_bloc_template/domain/entities/produk.dart';

class ProdukModel extends Produk {
  const ProdukModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image
  });
  
  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
    id: json['id'],
    title: json['title'],
    price: json['price'].toString(),
    description: json['description'],
    category: json['category'],
    image: json['image']
  );
}