import 'package:cloud_firestore/cloud_firestore.dart';

class DelieverOrder {
  final String orderId;
  final String receiverId;
  final String senderId;
  String status;
  double rating;
  final DateTime createdAt;
  String review;
  String accountNumber;
  String? fileAttachment; // Can be a URL or a file path

  DelieverOrder({
    required this.orderId,
    required this.receiverId,
    required this.senderId,
    this.status = 'pending',
    this.rating = 0,
    this.review = '',
    required this.createdAt,
    required this.accountNumber,
    this.fileAttachment,
  });

  toMap() {
    return {
      "OrderId": orderId,
      "ReceiverId": receiverId,
      "SenderId": senderId,
      "Status": status,
      "Rating": rating,
      'CreatedAt': createdAt.toUtc(),
      "Review": review,
      "AccountNumber": accountNumber,
      "FileAttachment": fileAttachment
    };
  }

  // Convert a map to an OrderModel instance
  factory DelieverOrder.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DelieverOrder(
      orderId: data["OrderId"],
      receiverId: data["ReceiverId"],
      senderId: data["SenderId"],
      status: data["Status"],
      rating: data["Rating"],
      review: data["Review"],
      createdAt: (data['CreatedAt'] as Timestamp).toDate(),
      accountNumber: data["AccountNumber"],
      fileAttachment: data["FileAttachment"],
    );
  }
}
