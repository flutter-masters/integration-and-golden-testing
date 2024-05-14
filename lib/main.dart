import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/no_internet/presentation/screen/no_internet_screen.dart';
import 'features/profile/presentation/screen/profile_screen.dart';
import 'features/sign_in/presentation/screen/sign_in_screen.dart';
import 'shared/providers/app_initialization_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(appInitializationProvider).when(
          skipLoadingOnRefresh: true,
          data: (result) => switch (result) {
            NoInternet() => const NoInternetScreen(),
            Initializated data => GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: MaterialApp(
                  themeMode: ThemeMode.dark,
                  darkTheme: ThemeData.dark(),
                  initialRoute:
                      data.appUser != null ? ProfileScreen.routePath : SignInScreen.routePath,
                  routes: {
                    ProfileScreen.routePath: (_) => const ProfileScreen(),
                    SignInScreen.routePath: (_) => const SignInScreen(),
                  },
                ),
              ),
          },
          loading: () => Material(
            color: ThemeData.dark().scaffoldBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (_, __) => const SizedBox.shrink(),
        );
  }
}
