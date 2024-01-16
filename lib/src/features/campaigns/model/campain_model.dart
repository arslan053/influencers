import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';

class CampaignModel {
  final String? id;
  String? brandId;
  final String description;
  final String totalPrice;
  final String delieveryTime;
  final String category;
  final DateTime createdAt;
  final String status;

  CampaignModel(
      {this.id,
      this.brandId,
      required this.description,
      required this.totalPrice,
      required this.delieveryTime,
      required this.category,
      required this.createdAt,
      required this.status});

  toMap() {
    return {
      "Description": description,
      "TotalPrice": totalPrice,
      "delieveryTime": delieveryTime,
      "BrandId": brandId,
      "Category": category,
      "CreatedAt": createdAt.toUtc(),
      "Status": status
    };
  }

  factory CampaignModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CampaignModel(
        id: document.id,
        brandId: data["BrandId"],
        description: data["Description"],
        totalPrice: data["TotalPrice"],
        delieveryTime: data["delieveryTime"],
        category: data["Category"] ?? '',
        createdAt: (data["CreatedAt"] as Timestamp).toDate(),
        status: data["Status"]);
  }
}
