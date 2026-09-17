import 'package:flutter_test/flutter_test.dart';
import 'package:kimiaxplore/main.dart';

void main() {
  testWidgets('KimiaXplore app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const KimiaXploreApp());

    expect(find.byType(KimiaXploreApp), findsOneWidget);
  });
}