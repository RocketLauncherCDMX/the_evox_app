import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_evox_app/repositories/user_profile_repository.dart';

// -----------------------------------------------------------------------------

// For Goggle registration and signin

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  return firebaseAuth;
});

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final UserProfileRepository profileRepository = UserProfileRepository();
  return profileRepository;
});

// -----------------------------------------------------------------------------

// For email and password authentication

final userNameProvider = StateProvider<String>((ref) {
  String userName = '';
  return userName;
});

final userEmailProvider = StateProvider<String>((ref) {
  String userEmail = '';
  return userEmail;
});

// -----------------------------------------------------------
