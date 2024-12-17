import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../shared_pref.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());

  void toggle() {
    if (state is AppThemeInitial) {
      print("shared = ${sharedPreferences!.getString("appTheme")}");
      if (sharedPreferences!.getString("appTheme") != null) {
        if (sharedPreferences!.getString("appTheme") == "light") {
          emit(AppLightTheme());
        } else if (sharedPreferences!.getString("appTheme") == "dark") {
          emit(AppDarkTheme());
        }
      } else {
        print("state $state");
        emit(AppLightTheme());
      }
    } else if (state is AppLightTheme) {
      sharedPreferences!.setString("appTheme", "dark");
      print("shared1 = ${sharedPreferences!.getString("appTheme")}");
      emit(AppDarkTheme());
    } else if (state is AppDarkTheme) {
      sharedPreferences!.setString("appTheme", "light");
      print("shared2 = ${sharedPreferences!.getString("appTheme")}");
      emit(AppLightTheme());
    } else {
      emit(AppDarkTheme());
    }
  }
}
