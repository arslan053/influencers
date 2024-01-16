import 'package:cloud_firestore/cloud_firestore.dart';

class Bid {
  final String? id;
  final String campaignId;
  final String influencerId;
  final double bidAmount;
  final String remarks;
  final DateTime createdAt;
  String bidStatus;
  final int deliveryDays;
  final String deliverables;

  Bid(
      {this.id,
      required this.campaignId,
      required this.influencerId,
      required this.bidAmount,
      this.deliverables = '',
      this.remarks = '',
      required this.createdAt,
      this.bidStatus = 'pending', // Default status
      required this.deliveryDays});

  Map<String, dynamic> toMap() {
    return {
      'CampaignId': campaignId,
      'InfluencerId': influencerId,
      'BidAmount': bidAmount,
      'Remarks': remarks,
      'CreatedAt': createdAt.toUtc(),
      'BidStatus': bidStatus,
      'DeliveryDays': deliveryDays,
      'Deliverables': deliverables
    };
  }

  factory Bid.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Bid(
        id: document.id,
        campaignId: data['CampaignId'],
        influencerId: data['InfluencerId'],
        bidAmount: data['BidAmount'],
        remarks: data['Remarks'] ?? '',
        createdAt: (data['CreatedAt'] as Timestamp).toDate(),
        bidStatus: data['BidStatus'] ?? 'pending',
        deliverables: data['Deliverables'],
        deliveryDays: data['DeliveryDays']);
  }
}
