import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/repository/campaign_repository.dart/campaign_repository.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../model/campain_model.dart';

class CampaignController extends GetxController {
  final _authRepo = Get.put(AuthenticationRepository());
  static CampaignController get instance => Get.find();

  final description = TextEditingController();
  final totalPrice = TextEditingController();
  final delieveryTime = TextEditingController();
  final expireInDays = TextEditingController();
  var selectedCategory = ''.obs;

  void setSelectedCategory(String newValue) {
    selectedCategory.value = newValue;
  }

  createCampaign(CampaignModel campaign) {
    campaign.brandId = _authRepo.firebaseUser.value?.uid;
    CampaignRepository.instance.createCampaign(campaign);
  }
}
