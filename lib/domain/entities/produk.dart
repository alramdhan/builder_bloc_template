import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  final int id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;

  const Produk({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, price, description, category, image];
}