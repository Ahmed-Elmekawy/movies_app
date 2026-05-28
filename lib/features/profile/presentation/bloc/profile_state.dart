import '../../../auth/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final UserEntity userEntity;
  UpdateProfileSuccess(this.userEntity);
}

class UpdateProfileFailure extends ProfileState {
  final String message;
  UpdateProfileFailure(this.message);
}

class AddToWatchListLoading extends ProfileState {}

class AddToWatchListSuccess extends ProfileState {
  final UserEntity userEntity;
  AddToWatchListSuccess(this.userEntity);
}

class AddToWatchListFailure extends ProfileState {
  final String message;
  AddToWatchListFailure(this.message);
}

class AddToHistoryLoading extends ProfileState {}

class AddToHistorySuccess extends ProfileState {
  final UserEntity userEntity;
  AddToHistorySuccess(this.userEntity);
}

class AddToHistoryFailure extends ProfileState {
  final String message;
  AddToHistoryFailure(this.message);
}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserEntity userEntity;
  ProfileSuccess(this.userEntity);
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}
