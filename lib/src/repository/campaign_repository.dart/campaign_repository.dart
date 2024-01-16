import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../features/campaigns/model/campain_model.dart';

class CampaignRepository extends GetxController {
  static CampaignRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createCampaign(CampaignModel campaign) async {
    await Firebase.initializeApp();
    final userCampaign = campaign.toMap();
    await _db.collection("Campaigns").add(userCampaign);
  }

  Stream<List<CampaignModel>> getAllCampaignsAsStream() {
    return _db
        .collection("Campaigns")
        .orderBy("CreatedAt",
            descending: true) // Order by "createdAt" in descending order
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CampaignModel.fromSnapShot(doc))
          .toList();
    });
  }

  Stream<List<CampaignModel>> getMyCampaigns() {
    final myUid = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection("Campaigns")
        .where("BrandId", isEqualTo: myUid) // Filter by BrandId
        .orderBy("CreatedAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CampaignModel.fromSnapShot(doc))
          .toList();
    });
  }

  Stream<List<CampaignModel>> getCampaignsByCategory(String category) {
    return _db
        .collection("Campaigns")
        .where("Category", isEqualTo: category) // Filter by Category
        .orderBy("CreatedAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CampaignModel.fromSnapShot(doc))
          .toList();
    });
  }
}
