import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_and_golden_testing/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:integration_and_golden_testing/main.dart';
import 'package:integration_and_golden_testing/shared/providers/appwrite_provider.dart';
import 'package:integration_and_golden_testing/shared/providers/internet_checker_provider.dart';
import 'package:mockito/mockito.dart';

import '../../../../mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'SignInScreen',
    (tester) async {
      final internetConnection = MockInternetConnection();
      final client = MockClient();

      when(internetConnection.hasInternetAccess).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          return true;
        },
      );

      when(
        client.call(
          any,
          path: '/account/sessions/current',
        ),
      ).thenThrow(
        Error(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            internetCheckerProvider.overrideWith(
              (_) => internetConnection,
            ),
            appwriteProvider.overrideWith(
              (_) => client,
            ),
          ],
          child: const MyApp(),
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

      await expectLater(
        find.byType(SignInScreen),
        matchesGoldenFile('golden/SignInScreen.png'),
      );
    },
  );
}
