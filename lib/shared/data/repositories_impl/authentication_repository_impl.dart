import 'package:appwrite/appwrite.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final Account _account;

  AuthenticationRepositoryImpl({
    required Account account,
  }) : _account = account;

  @override
  Future<AppUser?> get authenticatedUser async {
    try {
      await _account.getSession(sessionId: 'current');
      final user = await _account.get();
      return AppUser(
        id: user.$id,
        email: user.email,
        name: user.name,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return true;
    } catch (_) {
      return false;
    }
  }
}
