import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../repository/bid_repository/bid_repository.dart';
import '../model/bid_model.dart';

class BidController extends GetxController {
  static BidController get instance => Get.find();
  final bidRepository = Get.put(BidRepository());
  void makeBid(Bid bid) async {
    print("Function is being called");
    await bidRepository.submitBidToFirebase(bid);
  }
}
