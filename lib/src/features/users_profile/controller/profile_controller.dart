import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';
import 'package:influencer/src/repository/users_repository/brand_repository.dart';
import 'package:influencer/src/repository/users_repository/influencer_repository.dart';

class ProfileController extends GetxController {
  final _authRepo = Get.put(AuthenticationRepository());
  final _influencerRepo = Get.put(InfluencerRepository());
  final _brandRepo = Get.put(BrandRepository());
  ProfileModel? user;
  final _db = FirebaseFirestore.instance;

  // Future<ProfileModel?> getuserData() async {
  //   final email = _authRepo.firebaseUser.value?.email;
  //   if (email != null) {
  //     user = await _brandRepo.getBrandDetails(email);
  //     return user;
  //   } else {
  //     Get.snackbar("Error", "Login to continue");
  //   }
  // }

  Future<ProfileModel?> getAUser(String uid) async {
    print("the email of current user $uid");
    final influencerSnapshot = await _db
        .collection("Influencers")
        .where("UserId", isEqualTo: uid)
        .get();
    if (influencerSnapshot.docs.isNotEmpty) {
      print("Helllao i found the influencer.....<><><><><><><><><>");
      return influencerSnapshot.docs
          .map((e) => ProfileModel.fromSnapshot(e))
          .take(1)
          .first;
    } else if (influencerSnapshot.docs.isEmpty) {
      print("Helllao i didnot found the influencer.....<><><><><><><><><>");

      final brandSnapshot =
          await _db.collection("Brands").where("UserId", isEqualTo: uid).get();
      if (brandSnapshot.docs.isNotEmpty) {
        print("Helllao found the Brand.....<><><><><><><><><>");

        return ProfileModel.fromSnapshot(brandSnapshot.docs.first);
      }
    }
    Get.snackbar("Exception", "No user found");
    return null;
  }
}

// Future<ProfileModel?> getCurrentUser(String? email) async {
//   if (email == null) return null;

//   final influencerSnapshot = await _db
//       .collection("Influencers")
//       .where("UserId", isEqualTo: email)
//       .get();

//   if (influencerSnapshot.docs.isNotEmpty) {
//     return ProfileModel.fromSnapshot(influencerSnapshot.docs.first);
//   }
//   if (influencerSnapshot.docs.isEmpty) {
//     final brandSnapshot = await _db
//         .collection("Influencers")
//         .where("UserId", isEqualTo: email)
//         .get();
//     if (brandSnapshot.docs.isNotEmpty) {
//       return ProfileModel.fromSnapshot(brandSnapshot.docs.first);
//     }
//   }
// }
