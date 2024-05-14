import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool fetching;

  const SignInState({
    required this.email,
    required this.password,
    required this.fetching,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? fetching,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      fetching: fetching ?? this.fetching,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        fetching,
      ];
}
