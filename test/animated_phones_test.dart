import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/animated_phones.dart';

void main() {
  testWidgets(
    'Phones rise together before spreading to their final positions',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 900,
              height: 400,
              child: AnimatedPhones(mobile: false),
            ),
          ),
        ),
      );
      List<double> positions() => tester
          .widgetList<Positioned>(
            find.descendant(
              of: find.byType(AnimatedPhones),
              matching: find.byType(Positioned),
            ),
          )
          .map((phone) => phone.left!)
          .toList();
      final initial = positions();
      expect(initial.toSet().length, 1);
      await tester.pump(const Duration(milliseconds: 700));
      expect(positions(), initial);
      await tester.pumpAndSettle();
      final finalPositions = positions();
      expect(finalPositions[0], lessThan(finalPositions[2]));
      expect(finalPositions[1], greaterThan(finalPositions[2]));
      expect(tester.takeException(), isNull);
    },
  );
}
