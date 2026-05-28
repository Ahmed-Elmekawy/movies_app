import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../utils/cache_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  final CacheHelper _cacheHelper;

  LocaleCubit(this._cacheHelper) : super(const Locale('en')) {
    getSavedLanguage();
  }

  void getSavedLanguage() {
    final String? cachedLanguageCode = _cacheHelper.getString(key: CacheConstants.localeKey);
    if (cachedLanguageCode != null) {
      emit(Locale(cachedLanguageCode));
    } else {
      emit(const Locale('en'));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await _cacheHelper.setData(key: CacheConstants.localeKey, value: languageCode);
    emit(Locale(languageCode));
  }

  bool isEnglish() => state.languageCode == 'en';
}
