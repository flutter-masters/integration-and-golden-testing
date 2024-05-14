import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/app_user.dart';
import 'authentication_provider.dart';
import 'internet_checker_provider.dart';

final appInitializationProvider = FutureProvider(
  (ref) async {
    if (!await ref.read(internetCheckerProvider).hasInternetAccess) {
      return NoInternet();
    }

    final appUser = await ref.read(authenticationRepository).authenticatedUser;
    return Initializated(appUser: appUser);
  },
);

sealed class AppInitialization {}

class NoInternet extends AppInitialization {}

class Initializated extends AppInitialization {
  final AppUser? appUser;

  Initializated({required this.appUser});
}
