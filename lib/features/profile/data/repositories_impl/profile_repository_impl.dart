import 'package:appwrite/appwrite.dart';

import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Account _account;

  ProfileRepositoryImpl({required Account account}) : _account = account;

  @override
  Future<bool> updateName(String name) async {
    try {
      await _account.updateName(name: name);
      return true;
    } catch (_) {
      return false;
    }
  }
}
