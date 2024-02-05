import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_auth/data/interface_repositories/i_user_repository.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

class UserRepository implements IUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<ResultState<User>> createUser(
      {required String email,
      required String password,
      required String username,
      String? photoProfile}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<ResultState<User>> getUser({required String uid}) async {
    try {
      DocumentReference<Map<String, dynamic>> userRef =
          _firebaseFirestore.collection('users').doc(uid);

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
  Future<ResultState<User>> updateUser({required User user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<ResultState<User>> uploadPhotoProfile(
      {required String uid, required File photoPath}) {
    // TODO: implement uploadPhotoProfile
    throw UnimplementedError();
  }
}
