import 'package:flutter/material.dart';
import 'package:my_portfolio/app/configs/app_theme.dart';
import 'package:my_portfolio/app/configs/app_colors.dart';
import 'package:my_portfolio/app/widgets/contact_dialog.dart';
import 'package:my_portfolio/app/widgets/app_details_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:my_portfolio/app/modules/home/views/home_view.dart';
import 'package:my_portfolio/app/services/localizations.dart';

void main() {
  for (final width in [320.0, 390.0, 768.0, 1440.0]) {
    testWidgets('Portfolio and dark dialogs fit width $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(Get.reset);
      SharedPreferences.setMockInitialValues({'language_code': 'fr'});
      Get.put(HomeController());
      await tester.pumpWidget(
        GetMaterialApp(
          theme: buildAppTheme(textTheme: ThemeData.dark().textTheme),
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
      final controller = Get.find<HomeController>();
      controller.contactMe();
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.byType(ContactDialog))).brightness,
        Brightness.dark,
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byType(ContactDialog), findsNothing);
      final context = tester.element(find.byType(HomeView));
      showDialog<void>(
        context: context,
        builder: (_) => AppDetailsDialog(app: controller.mobileApps.first),
      );
      await tester.pumpAndSettle();
      expect(
        Theme.of(
          tester.element(find.byType(AppDetailsDialog)),
        ).colorScheme.primary,
        AppColors.primary,
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byType(AppDetailsDialog), findsNothing);
    });
  }
}
