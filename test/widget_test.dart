import 'package:flutter_test/flutter_test.dart';

import 'package:dukaan_dost_app/main.dart';

void main() {
  testWidgets('DukanDost app renders splash screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DukaanDostApp());

    expect(find.text('DukanDost'), findsOneWidget);
    expect(find.text('Aap ki dukan ka smart hisaab'), findsOneWidget);
  });
}
