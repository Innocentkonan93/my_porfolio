import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_portfolio/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/configs/app_theme.dart';
import 'app/services/localizations.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('language_code');
  runApp(MyApp(savedLang: savedLang));
}

class MyApp extends StatelessWidget {
  final String? savedLang;
  const MyApp({super.key, this.savedLang});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Innocent Konan Portfolio",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appTheme,
      translations: Localization(),
      locale: savedLang != null ? Locale(savedLang!) : Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en'), Locale('fr')],
    );
  }
}
