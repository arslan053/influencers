import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final name = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();

  // Call it from ui and it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }
}
