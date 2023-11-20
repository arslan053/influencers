import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/profile/model/profile_model.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';
import 'package:influencer/src/repository/influencer_repository/influencer_repository.dart';

class SetProfileController extends GetxController {
  final _authRepo = Get.put(AuthenticationRepository());
  static SetProfileController get instance => Get.find();
  final name = TextEditingController();
  final username = TextEditingController();
  final website = TextEditingController();
  final phonenumber = TextEditingController();
  final bio = TextEditingController();
  final description = TextEditingController();
  final email = Get.arguments.toString();
  final role = Rx<String>("");
  Rx<Uint8List?> image = Rx<Uint8List?>(null);

  void createUser(ProfileModel user, String role, Uint8List image) {
    final userUid = _authRepo.firebaseUser.value?.uid;
    if (userUid != null) {
      user.userId = userUid;
    }
    if (role == "influencer") {
      user.role = "Influencer";
      InfluencerRepository.instance.createInfluencer(user, image);
    } else {
      user.role = "Brand";

      InfluencerRepository.instance.createBrand(user, image);
    }
  }
}
