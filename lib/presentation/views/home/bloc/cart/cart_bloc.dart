

import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/domain/entities/cart.dart';
import 'package:builder_bloc_template/domain/usecases/get_cart_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase getCartUsecase;

  CartBloc(this.getCartUsecase) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      try {
        final cart = await getCartUsecase();
        emit(CartLoaded(cart.response));
      } catch(e) {
        sl<Logger>().e("Terjadi kesalahan");
      }
    });
  }
}