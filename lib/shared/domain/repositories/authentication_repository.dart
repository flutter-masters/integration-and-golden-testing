import '../entities/app_user.dart';

abstract interface class AuthenticationRepository {
  Future<AppUser?> get authenticatedUser;

  Future<bool> signOut();
}
