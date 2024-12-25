import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flutter Multi Table Widget Tests', () {
    testWidgets('App renders correctly with initial UI elements',
        (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify app bar title
      expect(find.text('Flutter Multi Table Example'), findsOneWidget);

      // Verify table headers are present
      expect(find.text('No'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Age'), findsOneWidget);
      expect(find.text('City'), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);

      // Verify initial data is displayed
      expect(find.text('1'), findsOneWidget);
      expect(find.text('John'), findsOneWidget);
      expect(find.text('New York'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);

      expect(find.text('2'), findsOneWidget);
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('London'), findsOneWidget);
      expect(find.text('Inactive'), findsOneWidget);

      // Verify submit button is present
      expect(find.text('Submit'), findsOneWidget);
    });
  });
}
