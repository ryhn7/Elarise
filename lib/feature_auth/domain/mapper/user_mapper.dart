import 'package:elarise/feature_auth/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../core/domain/entities/user_preferences.dart';

// Mapping FirebaseUser to User
User firebaseUserToUser(firebase_auth.User firebaseUser) {
  return User(
    email: firebaseUser.email ?? '',
    name: firebaseUser.displayName ?? '',
    photoProfile: firebaseUser
        .photoURL, // Notice the difference: photoURL in Firebase for Flutter
    uid: firebaseUser.uid,
  );
}

// Mapping FirebaseUser and token to UserPreferences
UserPreferences firebaseUserToUserPreference(
    firebase_auth.User firebaseUser, String token) {
  return UserPreferences(
    email: firebaseUser.email,
    name: firebaseUser.displayName,
    photoProfile:
        firebaseUser.photoURL ?? '', // Providing a default empty string if null
    uid: firebaseUser.uid,
    token: token,
  );
}

// Mapping UserPreferences to User
User userPreferenceToUser(UserPreferences userPreference) {
  return User(
    email: userPreference.email ?? '',
    name: userPreference.name ?? '',
    photoProfile: userPreference.photoProfile ?? '',
    uid: userPreference.uid ?? '',
  );
}
