part of 'produk_bloc.dart';

abstract class ProdukState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProdukInitial extends ProdukState {}
class ProdukLoading extends ProdukState {}
class ProdukLoaded extends ProdukState {
  final List<Produk> produks;
  ProdukLoaded(this.produks);

  @override
  List<Object?> get props => [produks];
}
class ProdukError extends ProdukState {
  final String message;
  ProdukError(this.message);

  @override
  List<Object?> get props => [message];
}