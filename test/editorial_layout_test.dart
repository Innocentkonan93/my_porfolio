import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:my_portfolio/app/modules/home/views/home_view.dart';
import 'package:my_portfolio/app/services/localizations.dart';

void main() {
  for (final width in [320.0, 390.0, 768.0, 1440.0]) {
    testWidgets('Editorial layout fits width $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(Get.reset);
      SharedPreferences.setMockInitialValues({'language_code': 'fr'});
      Get.put(HomeController());
      await tester.pumpWidget(
        GetMaterialApp(
          locale: const Locale('fr'),
          translations: Localization(),
          home: const HomeView(),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Explorer mes projets'));
      await tester.tap(find.text('Explorer mes projets'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Sites & applications web'));
      await tester.tap(find.text('Sites & applications web'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
