import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/app_user.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../../providers/app_initialization_provider.dart';
import '../../../providers/authentication_provider.dart';

final sessionProvider = NotifierProvider<SessionBloc, AppUser?>(
  () => SessionBloc(),
);

class SessionBloc extends Notifier<AppUser?> {
  late final AuthenticationRepository _authenticationRepository;
  @override
  AppUser? build() {
    _authenticationRepository = ref.read(authenticationRepositoryProvider);

    return switch (ref.read(appInitializationProvider).value) {
      Initializated data => data.appUser,
      _ => null,
    };
  }

  void setSession(AppUser appUser) {
    state = appUser;
  }

  Future<bool> signOut() async {
    if (await _authenticationRepository.signOut()) {
      state = null;
      return true;
    }
    return false;
  }
}
