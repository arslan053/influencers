import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final String campaignId;
  final String brandId;
  final String influencerId;
  final double bidAmount;
  final String status; // "accepted", "in_progress", "completed", etc.
  final DateTime deliveryDate;
  final DateTime createdAt;
  final String remarks;
  final String? deliverables; // Optional

  OrderModel({
    this.id,
    required this.campaignId,
    required this.brandId,
    required this.influencerId,
    required this.bidAmount,
    this.status = 'pending', // Default status
    required this.deliveryDate,
    required this.createdAt,
    this.remarks = '',
    this.deliverables,
  });

  Map<String, dynamic> toMap() {
    return {
      'CampaignId': campaignId,
      'BrandId': brandId,
      'InfluencerId': influencerId,
      'BidAmount': bidAmount,
      'Status': status,
      'DeliveryDate': deliveryDate.toUtc(),
      'CreatedAt': createdAt.toUtc(),
      'Remarks': remarks,
      'Deliverables': deliverables
    };
  }

  factory OrderModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return OrderModel(
      id: document.id,
      campaignId: data['CampaignId'],
      brandId: data['BrandId'],
      influencerId: data['InfluencerId'],
      bidAmount: data['BidAmount'],
      status: data['Status'] ?? 'pending',
      deliveryDate: (data['DeliveryDate'] as Timestamp).toDate(),
      createdAt: (data['CreatedAt'] as Timestamp).toDate(),
      remarks: data['Remarks'] ?? '',
      deliverables: data['Deliverables'],
    );
  }
}
