import 'package:cav_flutter_app/app/cav_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash transitions to CAV home screen', (tester) async {
    await tester.pumpWidget(const CavApp());

    expect(find.text('Photo studio, events, and coffee'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(
      find.text('Book photo sessions, event coverage, and cafe pickups.'),
      findsOneWidget,
    );
    expect(find.text('Studio'), findsWidgets);
    expect(find.text('Coffee'), findsWidgets);
  });
}
