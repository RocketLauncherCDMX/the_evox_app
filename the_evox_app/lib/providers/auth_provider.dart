import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/repositories/auth_provider_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(((ref) {
  return AuthRepository(FirebaseAuth.instance);
}));

final authStateProvider = StreamProvider<User?>(((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
}));
