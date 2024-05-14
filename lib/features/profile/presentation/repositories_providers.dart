import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/appwrite_provider.dart';
import '../data/repositories_impl/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';

final profileRepository = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    account: Account(
      ref.read(appwriteProvider),
    ),
  ),
);
