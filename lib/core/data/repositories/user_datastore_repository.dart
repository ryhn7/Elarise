import 'package:elarise/core/domain/entities/user_preferences.dart';

abstract class UserDatastoreRepository {
  Future<UserPreferences> getUser();
  Future<void> saveUser(UserPreferences user);
  Future<void> clearUserLogin();
  Future<void> saveToken(String token);
}
