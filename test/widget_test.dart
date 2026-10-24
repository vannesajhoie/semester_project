import 'package:flutter_test/flutter_test.dart';
import 'package:semester_project/app.dart';

void main() {
  testWidgets('Home page shows the main buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const ParkKeysApp());

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Register as Passenger'), findsOneWidget);
    expect(find.text('Register as Driver'), findsOneWidget);
  });
}
