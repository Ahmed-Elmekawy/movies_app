import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entities/movie_entity.dart';
import '../../domain/use_cases/add_to_history_use_case.dart';
import '../../domain/use_cases/add_to_watchlist_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final AddToWatchListUseCase _addToWatchListUseCase;
  final AddToHistoryUseCase _addToHistoryUseCase;

  ProfileCubit(
    this._updateProfileUseCase,
    this._addToWatchListUseCase,
    this._addToHistoryUseCase,
  ) : super(ProfileInitial());

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    emit(UpdateProfileLoading());
    final result = await _updateProfileUseCase(
      name: name,
      phone: phone,
      avatar: avatar,
    );
    result.fold(
      (failure) => emit(UpdateProfileFailure(failure.message)),
      (userEntity) => emit(UpdateProfileSuccess(userEntity)),
    );
  }

  Future<void> addToWatchList(MovieEntity movie) async {
    emit(AddToWatchListLoading());
    final result = await _addToWatchListUseCase(movie);
    result.fold(
      (failure) => emit(AddToWatchListFailure(failure.message)),
      (userEntity) => emit(AddToWatchListSuccess(userEntity)),
    );
  }

  Future<void> addToHistory(MovieEntity movie) async {
    emit(AddToHistoryLoading());
    final result = await _addToHistoryUseCase(movie);
    result.fold(
      (failure) => emit(AddToHistoryFailure(failure.message)),
      (userEntity) => emit(AddToHistorySuccess(userEntity)),
    );
  }
}
