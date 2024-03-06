import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../repository/delievery_repository/delievery_repository.dart';
import '../model/deliever_order_model.dart';

class DelieveryOrderController extends GetxController {
  static DelieveryOrderController get instance => Get.find();
  final delieverRepository = Get.put(DelieveryRepository());

  Future<void> createDeliveryOrder(DelieverOrder order, String? file) async {
    try {
      await delieverRepository.addDeliveryOrder(order, file);
    } catch (e) {
      Get.snackbar("Error", "Order not completed $e");
    }
  }
}
