import 'dart:io';

import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../../../core/data/repositories/user_datastore_repository.dart';
import '../../../feature_auth/domain/mapper/user_mapper.dart';

class SettingRepositoryImpl implements SettingRepository {
  final BaseAuthRepository _baseAuthRepository;
  final UserDatastoreRepository _userDatastoreRepository;

  SettingRepositoryImpl(
      {required BaseAuthRepository baseAuthRepository,
      required UserDatastoreRepository userDatastoreRepository})
      : _baseAuthRepository = baseAuthRepository,
        _userDatastoreRepository = userDatastoreRepository;

  @override
  Future<ResultState<bool>> logout() async {
    try {
      await _userDatastoreRepository.clearUserLogin();
      await _baseAuthRepository.logout();
      return const ResultState.success(true);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<User?>> updateProfile(
      {String? name, File? photoPath}) async {
    String filename = basename(photoPath?.path ??
        'https://firebasestorage.googleapis.com/v0/b/elarise-1d057.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=edfb4a25-2f56-479c-9ed3-f58e90ca8ce5');

    Reference reference =
        FirebaseStorage.instance.ref().child('profileImage/$filename');
    try {
      final firebaseUser = _baseAuthRepository.getCurrentUser();

      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(name);

        if (photoPath != null) {
          // Upload the file
          await reference.putFile(photoPath);

          // Get the download link
          String photoUrl = await reference.getDownloadURL();

          // Update the photo URL
          await firebaseUser.updatePhotoURL(photoUrl);
        }
        await firebaseUser.reload();
        final updatedUser = _baseAuthRepository.getCurrentUser();

        final user = firebaseUserToUser(updatedUser!);
        final token = await _baseAuthRepository.getUserToken() ?? '';

        //  Save user data to shared preferences

        final userPreference = firebaseUserToUserPreference(updatedUser, token);

        await _userDatastoreRepository.saveUser(userPreference);

        return ResultState.success(user);
      } else {
        return const ResultState.error('User not found');
      }
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<bool>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      bool reauthenticated =
          await _baseAuthRepository.reauthenticateWithPassword(currentPassword);

      if (!reauthenticated) {
        return const ResultState.error('Reauthentication failed');
      }

      await _baseAuthRepository.updatePassword(newPassword);
      return const ResultState.success(true);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<void>> deleteAccount() async {
    try {
      await _userDatastoreRepository.clearUserLogin();
      await _baseAuthRepository.deleteAccount();
      return const ResultState.success(true);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
