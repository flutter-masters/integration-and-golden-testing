import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/domain/entities/app_user.dart';
import '../../../../../shared/presentation/blocs/session/session_bloc.dart';
import '../../../domain/repositories/sign_in_repository.dart';
import '../../repositories_providers.dart';
import 'sign_in_state.dart';

final signInProvider = AutoDisposeNotifierProvider<SignInBloc, SignInState>(
  () => SignInBloc(),
);

class SignInBloc extends AutoDisposeNotifier<SignInState> {
  late final SignInRepository _signInRepository;
  late final SessionBloc _sessionBloc;

  @override
  SignInState build() {
    _signInRepository = ref.read(signInRespositoryProvider);
    _sessionBloc = ref.read(sessionProvider.notifier);
    return const SignInState(email: '', password: '', fetching: false);
  }

  void onEmailChanged(String email) {
    state = state.copyWith(
      email: email.trim(),
    );
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(
      password: password.trim(),
    );
  }

  Future<AppUser?> signIn() async {
    state = state.copyWith(fetching: true);
    final appUser = await _signInRepository.signIn(
      email: state.email,
      password: state.password,
    );
    if (appUser != null) {
      _sessionBloc.setSession(appUser);
      return appUser;
    }

    state = state.copyWith(fetching: false);
    return null;
  }
}
