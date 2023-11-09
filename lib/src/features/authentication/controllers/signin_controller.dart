import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';

class SigninController extends GetxController {
  static SigninController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();

  // Call it from ui and it will do the rest
  void signinUser(String email, String password) {
    AuthenticationRepository.instance
        .signinWithEmailAndPassword(email, password);
  }
}
