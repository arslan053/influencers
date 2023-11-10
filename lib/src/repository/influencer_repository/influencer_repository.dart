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
  late String? imageUrl;

  createInfluencer(UserModel user, Uint8List image) async {
    await Firebase.initializeApp();

    try {
      imageUrl = null;
      uploadImageToStorage("influenceraProfileImage", image).toString();
      if (imageUrl != null) {
        user.imageUrl = imageUrl;
      }
      final influencerUser = user.toMap();
      await _db
          .collection("Influencers")
          .add(influencerUser)
          .whenComplete(() => Get.snackbar(
              "Success:", "Your account has been created",
              backgroundColor:
                  Color.fromARGB(255, 33, 41, 34).withOpacity(0.5)))
          .catchError((error, stacktrace) {
        Get.snackbar("Error", "Something went wrong, try again",
            backgroundColor: Colors.redAccent.withOpacity(0.5));
      });
    } catch (e) {
      print("Error in createInfluencer: $e");
    }
  }

  createBrand(UserModel user, Uint8List image) async {
    await Firebase.initializeApp();

    try {
      imageUrl = null;
      uploadImageToStorage("influenceraProfileImage", image).toString();
      if (imageUrl != null) {
        user.imageUrl = imageUrl;
      }
      user.imageUrl = imageUrl;
      final brandUser = user.toMap();
      await _db
          .collection("Brands")
          .add(brandUser)
          .whenComplete(() => Get.snackbar(
              "Success:", "Your account has been created",
              backgroundColor: Colors.green.withOpacity(0.5)))
          .catchError((error, stacktrace) {
        Get.snackbar("Error", "Something went wrong, try again",
            backgroundColor: Colors.redAccent.withOpacity(0.5));
      });
    } catch (e) {
      print("Error in createInfluencer: $e");
    }
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    final fileName = '${childName}/${DateTime.now().millisecondsSinceEpoch}';

    Reference ref = _storage.ref().child(fileName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    imageUrl = downloadUrl;
    return downloadUrl;
  }
}
