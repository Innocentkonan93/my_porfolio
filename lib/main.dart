import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/configs/app_theme.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appTheme,
    );
  }
}
