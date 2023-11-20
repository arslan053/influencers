import 'package:get/get.dart';
import 'package:influencer/src/features/profile/model/profile_model.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';
import 'package:influencer/src/repository/influencer_repository/influencer_repository.dart';

class ProfileController extends GetxController {
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(InfluencerRepository());

  getuserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("user email $email");
    if (email != null) {
      ProfileModel user = await _userRepo.getInfluencerDetails(email);
      return user;
      print(user);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }
}
