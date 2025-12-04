part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// state sign in
class SigninInitial extends AuthState {}

class SigninLoading extends AuthState {}

class SigninSuccess extends AuthState {
  final UserEntity user;

  const SigninSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class SigninFailure extends AuthState {
  final FailureResponse error;

  const SigninFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// state sign up
class SignupInitial extends AuthState {}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {
  final UserEntity user;

  const SignupSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignupFailure extends AuthState {
  final FailureResponse error;

  const SignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class RememberMeState extends AuthState {
  final bool isChecked;

  const RememberMeState({this.isChecked = false});

  RememberMeState copyWith({bool? isChecked}) {
    return RememberMeState(isChecked: isChecked ?? this.isChecked);
  }

  @override
  List<Object?> get props => [isChecked];
}