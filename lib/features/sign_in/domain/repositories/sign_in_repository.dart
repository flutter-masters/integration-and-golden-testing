import '../../../../shared/domain/entities/app_user.dart';

abstract interface class SignInRepository {
  Future<AppUser?> signIn({
    required String email,
    required String password,
  });
}
