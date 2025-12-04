part of 'produk_bloc.dart';

abstract class ProdukEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProduksEvent extends ProdukEvent {}