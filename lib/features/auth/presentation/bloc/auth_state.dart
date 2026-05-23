import 'package:movies_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity userEntity;
  AuthSuccess(this.userEntity);
}

class RegisterSuccess extends AuthState {
  final UserEntity userEntity;
  RegisterSuccess(this.userEntity);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class Unauthenticated extends AuthState {}

class ForgotPasswordEmailSent extends AuthState {}
