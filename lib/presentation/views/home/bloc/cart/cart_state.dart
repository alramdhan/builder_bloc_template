part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}
class CartLoaded extends CartState {
  final Cart? cart;
  CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
  
  // Cart copyWith({
  //   int? id,
  //   int? userId,
  //   List<Produk>? products
  // }) {
  //   return Cart(id: id ?? cart.id, userId: userId ?? cart.userId, products: products ?? cart.products);
  // }
}