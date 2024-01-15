import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import '../../features/BotttonNavigation/views/bottom_navigation.dart';

class InfluencerRepository extends GetxController {
  static InfluencerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  late String? imageUrl;

  createInfluencer(ProfileModel user, Uint8List? image) async {
    await Firebase.initializeApp();

    try {
      await uploadImageToStorage("InfluencersProfileImage", image);
      if (imageUrl != null) {
        user.imageUrl = imageUrl;
      }
      final influencerUser = user.toMap();
      await _db.collection("Influencers").add(influencerUser).whenComplete(() {
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

  Future<String?> uploadImageToStorage(
      String childName, Uint8List? file) async {
    if (file != null) {
      imageUrl = null;
      final fileName = '$childName/${DateTime.now().millisecondsSinceEpoch}';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
      return downloadUrl;
    } else {
      return null;
    }
  }

  // to fetch the userdetail
  Future<ProfileModel> getInfluencerDetails(String uid) async {
    final snapshot =
        await _db.collection("Brands").where("UserId", isEqualTo: uid).get();
    print("Number of documents found: ${snapshot.docs.length}");
    if (snapshot.docs.isNotEmpty) {
      // Assuming you want to get the first document if multiple documents are present
      final userData = snapshot.docs
          .map((e) => ProfileModel.fromSnapshot(e))
          .take(1) // Take only the first element
          .first;
      return userData;
    } else {
      // Handle the case where there are no documents
      throw Exception('No Influencer found with this email');
    }
  }

  //To fetch the list of Influencer
  Future<List<ProfileModel>> getAllInfluencers() async {
    final snapshot = await _db.collection("Influencers").get();
    final usersData =
        snapshot.docs.map((e) => ProfileModel.fromSnapshot(e)).toList();
    return usersData;
  }
}
