import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/admin/views/admin_dashboard.dart';
import 'package:influencer/src/repository/influencer_repository/influencer_repository.dart';

import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../model/category_model.dart';

class CategoriesController extends GetxController {
  final _authRepo = Get.put(AuthenticationRepository());
  static CategoriesController get instance => Get.find();

  final category = TextEditingController();
  Rx<Uint8List?> image = Rx<Uint8List?>(null);
  late String? imageUrl;

  final _influencerRepo = Get.put(InfluencerRepository());
  final _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createCategory(CategoryModel category, Uint8List image) async {
    await Firebase.initializeApp();

    try {
      await uploadImageToStorage("Category", image);
      if (imageUrl != null) {
        category.imageUrl = imageUrl;
      }
      category.imageUrl = imageUrl;
      final addcategory = category.toMap();
      await _db.collection("Categories").add(addcategory).whenComplete(() {
        Get.offAll(AdminDashboard());
        Get.snackbar("Success:", "Your Category has been created",
            backgroundColor: Color.fromARGB(255, 33, 41, 34).withOpacity(0.5));
      }).catchError((error, stacktrace) {
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
}
