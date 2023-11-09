import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/authentication/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InfluencerRepository extends GetxController {
  static InfluencerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  createInfluencer(UserModel user, Uint8List image) async {
    await Firebase.initializeApp();

    try {
      user.imageurl =
          await uploadImageToStorage("inprofileImage", image).toString();
      final influencerUser = user.toMap();
      await _db
          .collection("Influencers")
          .add(influencerUser)
          .whenComplete(() => Get.snackbar(
              "Success:", "Your account has been created",
              backgroundColor: Colors.green.withOpacity(0.5)))
          .catchError((error, stacktrace) {
        Get.snackbar("Error", "Something went wrong, try again",
            backgroundColor: Colors.redAccent.withOpacity(0.1));
      });
    } catch (e) {
      print("Error in createInfluencer: $e");
    }
  }

  createBrand(UserModel user, Uint8List image) async {
    await Firebase.initializeApp();

    try {
      user.imageurl =
          await uploadImageToStorage("myprofileImage", image).toString();
      final brandUser = user.toMap();
      await _db
          .collection("Brands")
          .add(brandUser)
          .whenComplete(() => Get.snackbar(
              "Success:", "Your account has been created",
              backgroundColor: Colors.green.withOpacity(0.5)))
          .catchError((error, stacktrace) {
        Get.snackbar("Error", "Something went wrong, try again",
            backgroundColor: Colors.redAccent.withOpacity(0.1));
      });
    } catch (e) {
      print("Error in createInfluencer: $e");
    }
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
