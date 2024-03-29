import 'dart:io';

import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<ResultState<User>> createUser({
    required String email,
    required String username,
    String? photoProfile,
  });

  Future<ResultState<User>> getUser({required String uid});
  Future<ResultState<User>> updateUser({required User user});
  Future<ResultState<User>> uploadPhotoProfile(
      {required User user, required File photoPath});
}
