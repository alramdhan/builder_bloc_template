import 'package:flutter_bloc/flutter_bloc.dart';

class RemembermeCubit extends Cubit<bool> {
  RemembermeCubit() : super(false);

  void toggleRememberMe(bool? newValue) {
    if(newValue != null) {
      emit(newValue);
    }
  }
}