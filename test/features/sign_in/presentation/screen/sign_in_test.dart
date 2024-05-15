import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_and_golden_testing/features/no_internet/presentation/screen/no_internet_screen.dart';
import 'package:integration_and_golden_testing/main.dart';
import 'package:integration_and_golden_testing/shared/providers/internet_checker_provider.dart';
import 'package:mockito/mockito.dart';

import '../../../../mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'SignInScreen > no internet',
    (tester) async {
      final internetConnection = MockInternetConnection();

      when(internetConnection.hasInternetAccess).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          return false;
        },
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            internetCheckerProvider.overrideWith(
              (ref) => internetConnection,
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
        find.byType(NoInternetScreen),
        findsOneWidget,
      );
    },
  );
}
