// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../shared_pref.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());
  void changeLanguage(String lang) {
    sharedPreferences!.setString("appLang", lang);
    emit(LocalizationValue(lang: lang));
  }

  void toggle() {
    if (state is LocalizationInitial) {
      print("shared = ${sharedPreferences!.getString("appLang")}");
      if (sharedPreferences!.getString("appLang") != null) {
        if (sharedPreferences!.getString("appLang") == "en") {
          emit(LocalizationEn());
        } else if (sharedPreferences!.getString("appLang") == "ar") {
          emit(LocalizationAr());
        }
      } else {
        print("state $state");
        emit(LocalizationEn());
      }
    } else if (state is LocalizationEn) {
      sharedPreferences!.setString("appLang", "ar");
      print("shared1 = ${sharedPreferences!.getString("appLang")}");
      emit(LocalizationAr());
    } else if (state is LocalizationAr) {
      sharedPreferences!.setString("appLang", "en");
      print("shared2 = ${sharedPreferences!.getString("appLang")}");
      emit(LocalizationEn());
    } else {
      emit(LocalizationAr());
    }
  }
}
