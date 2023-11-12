import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
}
