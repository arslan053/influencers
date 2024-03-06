import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/deliever_order/model/deliever_order_model.dart';

class DelieveryRepository extends GetxController {
  static DelieveryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  late String? imageUrl;
  String? fileUrl;

  Future<void> addDeliveryOrder(
      DelieverOrder order, String? selectedFilePath) async {
    await Firebase.initializeApp();
    if (selectedFilePath != null) {
      File file = File(selectedFilePath);
      Uint8List fileBytes = await file.readAsBytes();
      fileUrl = await uploadFileToStorage("DeliveryOrderFiles", fileBytes);
    } else {
      fileUrl = '';
    }

    try {
      if (fileUrl != null) {
        order.fileAttachment = fileUrl;
      }
      final orderData = order.toMap();
      await _db.collection("DeliveryOrders").add(orderData).whenComplete(() {
        Get.snackbar("Success:", "Delivery order has been created",
            backgroundColor: Color.fromARGB(255, 33, 41, 34).withOpacity(0.5));
      }).catchError((error, stacktrace) {
        Get.snackbar("Error", "Something went wrong, try again",
            backgroundColor: Colors.redAccent.withOpacity(0.5));
      });
      await _db
          .collection('Orders')
          .doc(order.orderId)
          .update({'Status': 'delivered'});
    } catch (e) {
      Get.snackbar("Error", "Error in createDeliveryOrder: $e");
    }
  }

  Future<String?> uploadFileToStorage(String childName, Uint8List? file) async {
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
}
