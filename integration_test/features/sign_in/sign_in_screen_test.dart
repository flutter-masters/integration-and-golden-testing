import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_and_golden_testing/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:integration_and_golden_testing/main.dart';
import 'package:integration_and_golden_testing/shared/providers/appwrite_provider.dart';
import 'package:integration_test/integration_test.dart';

Future<void> deleteSession() async {
  try {
    await Account(appwriteClient).deleteSession(sessionId: 'current');
  } catch (_) {}
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(
    () async {
      await deleteSession();
    },
  );

  testWidgets(
    'SignIn successful',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      expect(
        find.byKey(const Key('main-loader')),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(SignInScreen),
        findsOneWidget,
      );
    },
  );
}
