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
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<AuthState> emit
  ) async {
    emit(SigninLoading());

    final result = await useCase(event.email, event.password);

    print("res ${result.message}");
  }
}