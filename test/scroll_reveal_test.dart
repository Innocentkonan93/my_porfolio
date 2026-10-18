import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/modules/home/views/widgets/scroll_reveal.dart';

void main() {
  testWidgets('Offscreen content reveals once after scrolling into view', (
    tester,
  ) async {
    final scroll = ScrollController();
    addTearDown(scroll.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          controller: scroll,
          child: const Column(
            children: [
              SizedBox(height: 1000),
              ScrollReveal(child: SizedBox(height: 100, child: Text('Reveal'))),
              SizedBox(height: 1000),
            ],
          ),
        ),
      ),
    );
    final fade = find.descendant(
      of: find.byType(ScrollReveal),
      matching: find.byType(FadeTransition),
    );
    double opacity() => tester.widget<FadeTransition>(fade).opacity.value;
    expect(opacity(), 0);
    scroll.jumpTo(800);
    await tester.pumpAndSettle();
    expect(opacity(), 1);
    scroll.jumpTo(0);
    await tester.pumpAndSettle();
    expect(opacity(), 1);
  });

  testWidgets('Reduced motion shows content immediately', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: ScrollReveal(child: Text('Visible')),
        ),
      ),
    );
    final fade = find.descendant(
      of: find.byType(ScrollReveal),
      matching: find.byType(FadeTransition),
    );
    expect(tester.widget<FadeTransition>(fade).opacity.value, 1);
  });
}
