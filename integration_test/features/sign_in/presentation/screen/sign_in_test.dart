import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_and_golden_testing/features/profile/presentation/screen/profile_screen.dart';
import 'package:integration_and_golden_testing/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:integration_and_golden_testing/main.dart';
import 'package:integration_and_golden_testing/shared/providers/appwrite_provider.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(
    () async {
      try {
        await Account(appwriteClient).deleteSession(sessionId: 'current');
      } catch (_) {}
    },
  );

  testWidgets(
    'SignInScreen success',
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

      await tester.enterText(
        find.byKey(const Key('email-input')),
        'test@test.com',
      );

      await tester.pump();

      await tester.enterText(
        find.byKey(const Key('password-input')),
        'Test123@',
      );

      await tester.pump();

      await tester.tap(
        find.byKey(
          const Key('submit-button'),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(ProfileScreen),
        findsOneWidget,
      );
    },
  );
}
