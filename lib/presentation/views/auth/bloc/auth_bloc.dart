import 'package:builder_bloc_template/data/models/base_response.dart';
import 'package:builder_bloc_template/domain/entities/user_entity.dart';
import 'package:builder_bloc_template/domain/usecases/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase useCase;
  AuthBloc({required this.useCase}) : super(SigninInitial()) {
    on<SigninSubmitted>(_onSigninSubmitted);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<AuthState> emit
  ) async {
    emit(SigninLoading());

    final result = await useCase(event.email, event.password);
    if(result.success) {
      emit(SigninSuccess(user: result.response!));
    } else {
      emit(SigninFailure(result as FailureResponse));
    }
    
    emit(SigninInitial());
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<AuthState> emit
  ) async {
    emit(SignupLoading());

    final result = await useCase(event.email, event.password, isLogin: false);
    if(result.success) {
      // emit(SigninSuccess(user: result.data));
    } else {
      // emit(SignupFailure(result));
    }
    print("res ${result}");
    emit(SignupInitial());
  }
}