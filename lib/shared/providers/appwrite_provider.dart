import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appwriteClient = Client()
    .setEndpoint(
      const String.fromEnvironment('endpoint'),
    )
    .setProject(
      const String.fromEnvironment('projectId'),
    );

final appwriteProvider = Provider(
  (_) => appwriteClient,
);
