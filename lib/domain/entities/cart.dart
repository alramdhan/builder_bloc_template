import 'package:builder_bloc_template/domain/entities/produk.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int id;
  final int userId;
  final List<Produk> products;

  const Cart({
    required this.id,
    required this.userId,
    required this.products
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, products];
}