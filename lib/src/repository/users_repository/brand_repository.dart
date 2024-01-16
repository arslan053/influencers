import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import 'package:influencer/src/repository/users_repository/influencer_repository.dart';
import '../../features/BotttonNavigation/views/bottom_navigation.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  late String? imageUrl;
  final influencerController = Get.put(InfluencerRepository());
  createBrand(ProfileModel user, Uint8List image) async {
    await Firebase.initializeApp();

    try {
      imageUrl = await influencerController.uploadImageToStorage(
          "BrandsProfileImage", image);
      if (imageUrl != null) {
        user.imageUrl = imageUrl;
      }
      user.imageUrl = imageUrl;
      final brandUser = user.toMap();
      await _db.collection("Brands").add(brandUser).whenComplete(() {
        Get.offAll(MyHomePage());
        Get.snackbar("Success:", "Your account has been created",
            backgroundColor: Color.fromARGB(255, 33, 41, 34).withOpacity(0.5));
      }).catchError((error, stacktrace) {
        Get.snackbar("Error", "Something went wrong, try again",
            backgroundColor: Colors.redAccent.withOpacity(0.5));
      });
    } catch (e) {
      print("Error in createInfluencer: $e");
    }
  }

  // to fetch the userdetail
  Future<ProfileModel> getBrandDetails(String uid) async {
    final snapshot =
        await _db.collection("Brands").where("UserId", isEqualTo: uid).get();
    if (snapshot.docs.isNotEmpty) {
      // Assuming you want to get the first document if multiple documents are present
      final userData = snapshot.docs
          .map((e) => ProfileModel.fromSnapshot(e))
          .take(1) // Take only the first element
          .first;
      return userData;
    } else {
      // Handle the case where there are no documents
      throw Exception('No brand found with this email');
    }
  }

  //To fetch the list of Userdata
  Future<List<ProfileModel>> getAllBrands() async {
    final snapshot = await _db.collection("Brands").get();
    final usersData =
        snapshot.docs.map((e) => ProfileModel.fromSnapshot(e)).toList();
    return usersData;
  }
}
