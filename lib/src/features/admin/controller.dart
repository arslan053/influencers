import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdminController extends GetxController {
  Future<int> getBrandCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            'Brands') // Replace 'Brands' with the actual name of your collection
        .get();

    return querySnapshot.docs.length;
  }
}
