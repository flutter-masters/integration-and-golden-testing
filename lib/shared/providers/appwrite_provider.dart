import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appwriteProvider = Provider(
  (_) => Client()
      .setEndpoint(
        'https://cloud.appwrite.io/v1',
      )
      .setProject(
        'flutter-masters-community',
      ),
);
