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
      await uploadImageToStorage("nfluenceraProfileImage", image);
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
      await uploadImageToStorage("bnfluenceraProfileImage", image);
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
    imageUrl = null;
    final fileName = '$childName/${DateTime.now().millisecondsSinceEpoch}';
    Reference ref = _storage.ref().child(fileName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    imageUrl = downloadUrl;
    return downloadUrl;
  }

  // to fetch the userdetail
  Future<UserModel> getInfluencerDetails(String email) async {
    final snapshot = await _db
        .collection("Influencers")
        .where("Email", isEqualTo: email)
        .get();
    print(snapshot);
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  //To fetch the list of Userdata
  Future<List<UserModel>> getAllInfluencers() async {
    final snapshot = await _db.collection("Influencers").get();
    final usersData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return usersData;
  }

  // to fetch the userdetail
  Future<UserModel> getBrandDetails(String email) async {
    final snapshot =
        await _db.collection("Brands").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  //To fetch the list of Userdata
  Future<List<UserModel>> getAllBrands() async {
    final snapshot = await _db.collection("Brands").get();
    final usersData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return usersData;
  }
}
