import 'package:flutter_bloc/flutter_bloc.dart';

class MenutabCubit extends Cubit<int> {
  MenutabCubit(): super(0);

  void onSelecTab(int index) {
    emit(index);
  }
}