import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_auth/data/repositories/user_repository.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepositoryImpl({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<ResultState<User>> createUser(
      {required String email,
      required String username,
      String? photoProfile}) async {
    try {
      CollectionReference<Map<String, dynamic>> usersRef =
          _firebaseFirestore.collection('Users');

      await usersRef.add({
        'email': email,
        'username': username,
        'photoProfile': photoProfile,
      });

      DocumentSnapshot<Map<String, dynamic>> result =
          await usersRef.doc(email).get();

      if (result.exists) {
        return ResultState.success(User.fromJson(result.data()!));
      } else {
        return const ResultState.error('Failed to create user');
      }
    } on FirebaseException catch (e) {
      return ResultState.error(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<ResultState<User>> getUser({required String uid}) async {
    try {
      DocumentReference<Map<String, dynamic>> userRef =
          _firebaseFirestore.collection('Users').doc(uid);

      DocumentSnapshot<Map<String, dynamic>> result = await userRef.get();

      if (result.exists) {
        return ResultState.success(User.fromJson(result.data()!));
      } else {
        return const ResultState.error('User not found');
      }
    } on FirebaseException catch (e) {
      return ResultState.error(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<ResultState<User>> updateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> userRef =
          _firebaseFirestore.collection('users').doc(user.uid);

      await userRef.update(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result = await userRef.get();

      if (result.exists) {
        User updatedUser = User.fromJson(result.data()!);
        if (updatedUser == user) {
          return ResultState.success(updatedUser);
        } else {
          return const ResultState.error('Failed to update user');
        }
      } else {
        return const ResultState.error('User not found');
      }
    } on FirebaseException catch (e) {
      return ResultState.error(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<ResultState<User>> uploadPhotoProfile(
      {required User user, required File photoPath}) async {
    String filename = basename(photoPath.path);

    Reference reference = FirebaseStorage.instance.ref().child(filename);

    try {
      await reference.putFile(photoPath);

      String photoUrl = await reference.getDownloadURL();

      var updatedResult =
          await updateUser(user: user.copyWith(photoProfile: photoUrl));

      if (updatedResult.isSuccess) {
        return ResultState.success(updatedResult.resultData!);
      } else {
        return ResultState.error(updatedResult.errorMessage!);
      }
    } catch (e) {
      return const ResultState.error(
          'An error occurred while uploading photo profile');
    }
  }
}
