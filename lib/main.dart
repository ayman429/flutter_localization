import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:flutter_localization/cubits/localization_cubit/localization_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubits/shared_pref.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  print("main = ${sharedPreferences!.get("appTheme")}");
  runApp(const FlutterLocalization());
}

class FlutterLocalization extends StatelessWidget {
  const FlutterLocalization({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalizationCubit()..toggle()),
        BlocProvider(create: (context) => AppThemeCubit()..toggle()),
      ],
      child: Builder(
        builder: (context) {
          var themeState = context.select((AppThemeCubit cubit) => cubit.state);
          var langState =
              context.select((LocalizationCubit cubit) => cubit.state);
          // String appLang = sharedPreferences!.getString("appLang") ?? 'en';
          print("theme = $themeState");
          /* Multiple Localization EN - AR - FR */
          // if (langState is LocalizationInitial ||
          //     langState is LocalizationValue) {
          //   String appLang = sharedPreferences!.getString("appLang") ?? 'en';

          //   return MaterialApp(
          //     theme: themeState is AppLightTheme
          //         ? ThemeData.light()
          //         : ThemeData.dark(),
          //     locale: Locale(
          //         langState is LocalizationValue ? langState.lang : appLang),
          //     debugShowCheckedModeBanner: false,
          //     localizationsDelegates: const <LocalizationsDelegate<Object>>[
          //       S.delegate,
          //       GlobalMaterialLocalizations.delegate,
          //       GlobalWidgetsLocalizations.delegate,
          //       GlobalCupertinoLocalizations.delegate,
          //     ],
          //     supportedLocales: S.delegate.supportedLocales,
          //     home: const HomeView(),
          //   );

          // } else {
          //   return Container();
          // }
          /* EN and AR */
          return MaterialApp(
            theme: themeState is AppLightTheme
                ? ThemeData.light()
                : ThemeData.dark(),
            locale: Locale(langState is LocalizationEn ? "en" : "ar"),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const <LocalizationsDelegate<Object>>[
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(S.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: const Text("change Theme"),
              onPressed: () {
                try {
                  BlocProvider.of<AppThemeCubit>(context).toggle();
                } catch (e) {
                  print("error = $e");
                }
              },
            ),
            MaterialButton(
              child: const Text("change Lang"),
              onPressed: () {
                try {
                  BlocProvider.of<LocalizationCubit>(context).toggle();
                } catch (e) {
                  print("error = $e");
                }
              },
            ),
            MaterialButton(
              child: const Text("en"),
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context)
                    .changeLanguage('en');
                try {
                  BlocProvider.of<AppThemeCubit>(context).toggle();
                } catch (e) {
                  print("error = $e");
                }
              },
            ),
            MaterialButton(
              child: const Text("ar"),
              onPressed: () async {
                BlocProvider.of<LocalizationCubit>(context)
                    .changeLanguage('ar');

                // try {
                //   await sharedPreferences!.remove("appTheme");
                //   print("don");
                // } catch (e) {
                //   print("e = $e");
                // }
              },
            ),
            MaterialButton(
              child: const Text("fr"),
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context)
                    .changeLanguage('fr');
              },
            ),
          ],
        ),
      ),
    );
  }
}
