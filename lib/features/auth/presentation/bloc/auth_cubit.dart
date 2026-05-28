import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/check_auth_status_use_case.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/send_password_reset_email_use_case.dart';
import '../../domain/use_cases/sign_in_with_email_and_password_use_case.dart';
import '../../domain/use_cases/sign_in_with_google_use_case.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import '../../domain/use_cases/sign_up_with_email_and_password_use_case.dart';
import '../../domain/use_cases/update_password_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailAndPasswordUseCase;
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;
  final SignOutUseCase _signOutUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;

  AuthCubit(
    this._signInWithGoogleUseCase,
    this._signInWithEmailAndPasswordUseCase,
    this._signUpWithEmailAndPasswordUseCase,
    this._sendPasswordResetEmailUseCase,
    this._signOutUseCase,
    this._checkAuthStatusUseCase,
    this._deleteAccountUseCase,
    this._updatePasswordUseCase,
  ) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await _checkAuthStatusUseCase();
    result.fold((failure) => emit(Unauthenticated()), (userEntity) {
      if (userEntity != null) {
        emit(AuthSuccess(userEntity));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await _signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userEntity) => emit(AuthSuccess(userEntity)),
    );
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _signInWithEmailAndPasswordUseCase(email, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userEntity) => emit(AuthSuccess(userEntity)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
  }) async {
    emit(AuthLoading());
    final result = await _signUpWithEmailAndPasswordUseCase(
      name: name,
      email: email,
      password: password,
      phone: phone,
      avatar: avatar,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userEntity) => emit(RegisterSuccess(userEntity)),
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    final result = await _sendPasswordResetEmailUseCase(email);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(ForgotPasswordEmailSent()),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await _signOutUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> deleteAccount(String password) async {
    final previousState = state;
    emit(DeleteAccountLoading());
    final result = await _deleteAccountUseCase(password);
    result.fold((failure) {
      emit(AuthFailure(failure.message));
      if (previousState is AuthSuccess) {
        emit(previousState);
      }
    }, (_) => emit(DeleteAccountSuccess()));
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final previousState = state;
    emit(AuthLoading());
    final result = await _updatePasswordUseCase(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    result.fold(
      (failure) {
        emit(AuthFailure(failure.message));
        if (previousState is AuthSuccess) {
          emit(previousState);
        }
      },
      (_) {
        emit(UpdatePasswordSuccess());
        logout();
      },
    );
  }
}
