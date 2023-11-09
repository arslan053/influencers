import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/authentication/model/user_model.dart';
import 'package:influencer/src/repository/influencer_repository/influencer_repository.dart';

class SetProfileController extends GetxController {
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
  void createUser(UserModel user, String role, Uint8List image) {
    print("<<<<<<<<<<<$role>>>>>>>>>>>");

    if (role == "influencer") {
      InfluencerRepository.instance.createInfluencer(user, image);
    } else {
      InfluencerRepository.instance.createBrand(user, image);
    }
  }
}
