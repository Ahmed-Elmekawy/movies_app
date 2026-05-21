import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/sign_in_with_google_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  AuthCubit(this._signInWithGoogleUseCase) : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await _signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userEntity) => emit(AuthSuccess(userEntity)),
    );
  }
}
