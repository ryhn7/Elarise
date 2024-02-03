import 'dart:io';

import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

abstract interface class IUserRepository {
  Future<ResultState<User>> createUser({
    required String email,
    required String password,
    required String username,
    String? photoProfile,
  });

  Future<ResultState<User>> getUser({required String uid});
  Future<ResultState<User>> updateUser({required User user});
  Future<ResultState<User>> uploadPhotoProfile(
      {required String uid, required File photoPath});
}
