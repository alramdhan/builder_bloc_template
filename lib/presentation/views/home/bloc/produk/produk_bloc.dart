import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/domain/entities/produk.dart';
import 'package:builder_bloc_template/domain/usecases/get_products_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final GetProductsUsecase getUseCase;

  ProdukBloc(this.getUseCase) : super(ProdukInitial()) {
    on<GetProduksEvent>((event, emit) async {
      emit(ProdukLoading());
      try {
        final produks = await getUseCase();
        emit(ProdukLoaded(produks.response ?? []));
      } catch(e) {
        sl<Logger>().e("Terjadi kesalahan");
        emit(ProdukError("Failed to fetch ${e.toString()}"));
      }
    });
  }
}