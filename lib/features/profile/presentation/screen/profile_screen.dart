import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/domain/entities/app_user.dart';
import '../../../../shared/presentation/blocs/session/session_bloc.dart';
import '../../../sign_in/presentation/screen/sign_in_screen.dart';
import '../repositories_providers.dart';
import 'widgets/profile_tile.dart';

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
              ProfileTile(
                label: 'ID',
                text: appUser.id,
                editable: false,
              ),
              const Divider(),
              ProfileTile(
                label: 'Email',
                text: appUser.email,
                editable: false,
              ),
              const Divider(),
              ProfileTile(
                label: 'Name',
                text: appUser.name,
                editable: true,
                onChanged: (text) => _onNameChanged(context, text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onNameChanged(BuildContext context, String text) async {
    final container = ProviderScope.containerOf(context);
    final updated = await container.read(profileRepository).updateName(text);

    if (!context.mounted) {
      return;
    }

    if (updated) {
      container.read(sessionProvider.notifier).setSession(
            container.read(sessionProvider)!.copyWith(name: text),
          );
    }

    final record = switch (updated) {
      true => (message: 'Name updated', color: Colors.blueAccent),
      false => (message: 'Error', color: Colors.redAccent),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          record.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: record.color,
      ),
    );
  }
}
