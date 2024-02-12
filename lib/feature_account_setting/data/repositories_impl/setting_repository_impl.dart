import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firebaseFirestore;

  SettingRepositoryImpl(
      {required BaseAuthRepository baseAuthRepository,
      required UserDatastoreRepository userDatastoreRepository,
      FirebaseFirestore? firebaseFirestore})
      : _baseAuthRepository = baseAuthRepository,
        _userDatastoreRepository = userDatastoreRepository,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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
        'https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=b59b54f9-84c0-47e0-a900-60bfa9b05ae9');

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
        } else {
          await firebaseUser.updatePhotoURL(
              'https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=b59b54f9-84c0-47e0-a900-60bfa9b05ae9');
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
}
