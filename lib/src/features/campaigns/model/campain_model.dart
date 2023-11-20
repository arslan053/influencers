import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:influencer/src/features/profile/model/profile_model.dart';

class CampaignModel {
  final String? id;
  String? brandId;
  final String description;
  final String totalPrice;
  final String delieveryTime;
  final String expireInDays;

  CampaignModel(
      {this.id,
      this.brandId,
      required this.description,
      required this.totalPrice,
      required this.delieveryTime,
      required this.expireInDays});

  toMap() {
    return {
      "Description": description,
      "TotalPrice": totalPrice,
      "delieveryTime": delieveryTime,
      "ExpiryInDays": expireInDays,
      "BrandId": brandId
    };
  }

  factory CampaignModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return CampaignModel(
        id: document.id,
        brandId: "BrandId",
        description: "Description",
        totalPrice: "TotalPrice",
        delieveryTime: "delieveryTime",
        expireInDays: "ExpiryInDays");
  }
}
