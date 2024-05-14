import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/blocs/session/session_bloc.dart';
import '../../../sign_in/presentation/screen/sign_in_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const routePath = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(sessionProvider);
    if (appUser == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              final success = await ProviderScope.containerOf(context)
                  .read(
                    sessionProvider.notifier,
                  )
                  .signOut();

              if (context.mounted && success) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.routePath,
                  (route) => false,
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(appUser.id),
              Text(appUser.email),
            ],
          ),
        ),
      ),
    );
  }
}
