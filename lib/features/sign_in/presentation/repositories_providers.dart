import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/appwrite_provider.dart';
import '../data/repositories_impl/sign_in_repository_impl.dart';
import '../domain/repositories/sign_in_repository.dart';

final signInRespositoryProvider = Provider<SignInRepository>(
  (ref) => SignInRepositoryImpl(
    account: Account(
      ref.read(appwriteProvider),
    ),
  ),
);
