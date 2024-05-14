import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/validators/form_validator.dart';
import '../../../profile/presentation/screen/profile_screen.dart';
import 'bloc/sign_in_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const routePath = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: FormValidator.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: ProviderScope.containerOf(context)
                      .read(signInProvider.notifier)
                      .onEmailChanged,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: FormValidator.password,
                  onChanged: ProviderScope.containerOf(context)
                      .read(signInProvider.notifier)
                      .onPasswordChanged,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, __) {
                    final state = ref.watch(signInProvider);
                    final allow = state.email.isNotEmpty && state.password.isNotEmpty;

                    if (state.fetching) {
                      return const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.blueAccent.withOpacity(allow ? 1 : 0.4),
                        ),
                      ),
                      onPressed: allow ? () => _submit(context) : null,
                      child: const Text('Sign In'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!Form.of(context).validate()) {
      return;
    }

    final bloc = ProviderScope.containerOf(context).read(signInProvider.notifier);
    final appUser = await bloc.signIn();
    if (!context.mounted) {
      return;
    }

    if (appUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid email or password',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacementNamed(
      ProfileScreen.routePath,
    );
  }
}
