import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/profile/model/profile_model.dart';

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
    return _db.collection("Campaigns").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CampaignModel.fromSnapShot(doc))
          .toList();
    });
  }
}
