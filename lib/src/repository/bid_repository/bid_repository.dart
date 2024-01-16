import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../features/bids/model/bid_model.dart';

class BidRepository extends GetxController {
  static BidRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> submitBidToFirebase(Bid bid) async {
    // Get a reference to the collection where bids are stored
    CollectionReference bids = _db.collection('Bids');

    // Convert the Bid object to a map
    Map<String, dynamic> bidData = bid.toMap();

    // Add the bid to the collection
    try {
      await bids.add(bidData);
      Get.snackbar("Successfull", "You have bid successfully to this Campaign");
    } catch (e) {
      Get.snackbar("Error", "Error Signing out $e");
    }
  }

  Stream<List<Bid>> getMyBidsAsStream(String campaignId) {
    return _db
        .collection("Bids")
        .where("CampaignId", isEqualTo: campaignId)
        .where("BidStatus",
            isEqualTo: "pending") // Additional condition for pending status
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Bid.fromSnapShot(doc)).toList();
    });
  }

  Future<void> deleteBid(String bidId) async {
    try {
      await _db.collection("Bids").doc(bidId).delete();
      print('Bid deleted successfully');
    } catch (e) {
      print('Error deleting bid: $e');
    }
  }
}
