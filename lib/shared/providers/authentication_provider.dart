import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories_impl/authentication_repository_impl.dart';
import '../domain/repositories/authentication_repository.dart';
import 'appwrite_provider.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    account: Account(
      ref.read(appwriteProvider),
    ),
  ),
);
