import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../features/bids/model/bid_model.dart';
import '../../features/model/model/order_model.dart';

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
          deliverables: acceptedBid.deliverables);

      // Convert the Order object to a map
      Map<String, dynamic> orderData = newOrder.toMap();

      // Save the order to your database
      // Assuming you are using Firestore, it might look something like this:
      var documentReference = FirebaseFirestore.instance
          .collection('Orders'); // Document ID generated automatically
      await documentReference.add(orderData);
      if (acceptedBid.id != null) {
        var bidDocumentReference =
            FirebaseFirestore.instance.collection('Bids').doc(acceptedBid.id);
        await bidDocumentReference.update({'BidStatus': 'accepted'});
        // You can add more code here if you need to perform additional actions after updating the bid
      }
      Get.snackbar("Successfull", "Order created successfully.");
    } catch (e) {
      Get.snackbar("Error", 'Error creating order: $e');
    }
  }
}
