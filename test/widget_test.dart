import 'package:cav_flutter_app/app/cav_app.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verifies that the splash screen transitions to the primary home screen.
void main() {
  testWidgets('Splash transitions to CAV home screen', (tester) async {
    await tester.pumpWidget(const CavApp());

    expect(find.text('Photo studio, photo services, and café'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Book studio sessions, photo services, and café pickups.',
      ),
      findsOneWidget,
    );
    expect(find.text('Studio'), findsWidgets);
    expect(find.text('Café'), findsWidgets);
  });
}
