import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../features/bids/model/bid_model.dart';
import '../../features/order/model/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();
  final brandUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> createOrderFromBid(Bid acceptedBid) async {
    try {
      // Create an Order object from the accepted bid
      OrderModel newOrder = OrderModel(
          campaignId: acceptedBid.campaignId,
          brandId: brandUid, // You need to provide the brandId here
          influencerId: acceptedBid.influencerId,
          bidAmount: acceptedBid.bidAmount,
          status: 'pending', // Initial status of the order
          deliveryDate:
              DateTime.now().add(Duration(days: acceptedBid.deliveryDays)),
          createdAt: DateTime.now(),
          remarks: acceptedBid.remarks,
          paymentStatus: 'unpaid',
          deliverables: acceptedBid.deliverables);

      // Convert the Order object to a map
      Map<String, dynamic> orderData = newOrder.toMap();

      var documentReference = FirebaseFirestore.instance.collection('Orders');
      await documentReference.add(orderData);
      if (acceptedBid.id != null) {
        var bidDocumentReference =
            FirebaseFirestore.instance.collection('Bids').doc(acceptedBid.id);
        await bidDocumentReference.update({'BidStatus': 'accepted'});
      }
      Get.snackbar("Successfull", "Order created successfully.");
    } catch (e) {
      Get.snackbar("Error", 'Error creating order: $e');
    }
  }

  Stream<List<OrderModel>> getOrdersByBrandId(String brandId) {
    return FirebaseFirestore.instance
        .collection('Orders')
        .where('BrandId', isEqualTo: brandId)
        .where('Status', whereIn: [
          'pending',
          'delivered',
          'revision'
        ]) // Only get orders with 'pending' or 'delivered' status
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromSnapShot(doc)).toList());
  }

  Stream<List<OrderModel>> getOrdersByInfluencerId(String influencerId) {
    return FirebaseFirestore.instance
        .collection('Orders')
        .where('InfluencerId', isEqualTo: influencerId)
        .where('Status', whereIn: [
          'pending',
          'delivered',
          'revision'
        ]) // Only get orders with 'pending' or 'delivered' status
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromSnapShot(doc)).toList());
  }
}
