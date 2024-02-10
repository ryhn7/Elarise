import 'package:elarise/core/data/repositories/user_datastore_repository.dart';
import 'package:elarise/core/domain/entities/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataStoreRepositoryImpl implements UserDatastoreRepository {
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _photoProfileKey = 'photoProfile';
  static const String _uidKey = 'uid';
  static const String _tokenKey = 'token';

  @override
  Future<void> clearUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_photoProfileKey);
    await prefs.remove(_uidKey);
    await prefs.remove(_tokenKey);
  }

  @override
  Future<UserPreferences> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return UserPreferences(
      name: prefs.getString(_nameKey),
      email: prefs.getString(_emailKey),
      photoProfile: prefs.getString(_photoProfileKey),
      uid: prefs.getString(_uidKey),
      token: prefs.getString(_tokenKey),
    );
  }

  @override
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<void> saveUser(UserPreferences user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, user.name ?? '');
    await prefs.setString(_emailKey, user.email ?? '');
    await prefs.setString(_photoProfileKey, user.photoProfile ?? '');
    await prefs.setString(_uidKey, user.uid ?? '');
    await prefs.setString(_tokenKey, user.token ?? '');
  }
}
