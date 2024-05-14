import 'dart:developer';

import 'package:appwrite/appwrite.dart';

import '../../../../shared/domain/entities/app_user.dart';
import '../../domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final Account _account;

  SignInRepositoryImpl({
    required Account account,
  }) : _account = account;

  @override
  Future<AppUser?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      final user = await _account.get();

      return AppUser(
        id: user.$id,
        email: user.email,
        name: user.name,
      );
    } catch (e, s) {
      log('signIn error', error: e, stackTrace: s);
      return null;
    }
  }
}
