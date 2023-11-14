import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/BotttonNavigation/bottomNavigation.dart';
import 'package:influencer/src/features/Dashboard/DashboardScreen.dart';
import 'package:influencer/src/features/admin/views/admin_dashboard.dart';
import 'package:influencer/src/features/authentication/views/login/login_screen.dart';
import 'package:influencer/src/features/authentication/views/signup/signup_screen.dart';
import 'package:influencer/src/features/authentication/views/set_profile/set_profile_screen.dart';
import 'package:influencer/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

import '../../features/authentication/model/user_model.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late Rx<User?> firebaseUser;
  UserModel? currentUser = null;

  _setIntialScreen(User? user) {
    user == null ? Get.offAll(() => const AdminDashboard()) : getuser();
  }

  getuser() async {
    if (currentUser == null) {
      final myuser = await getCurrentUser(firebaseUser.value?.uid.toString());
      currentUser = myuser;
      if (currentUser != null) {

        Get.offAll(() =>  MyHomePage());
      }
    } else {
      Get.offAll(() =>  MyHomePage());
    }
      
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    firebaseUser = await Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    print("the user id od user is ${firebaseUser.value?.uid.toString()}");
    // currentUser = await getCurrentUser(firebaseUser.value?.email);
    ever(firebaseUser, _setIntialScreen); // it is always ready to do action
  }

  Future<UserModel?> getCurrentUser(String? email) async {
    if (email == null) return null;

    final influencerSnapshot = await _db
        .collection("Influencers")
        .where("UserId", isEqualTo: email)
        .get();

    if (influencerSnapshot.docs.isNotEmpty) {
      return UserModel.fromSnapshot(influencerSnapshot.docs.first);
    }
    if (influencerSnapshot.docs.isEmpty) {
      final brandSnapshot = await _db
          .collection("Influencers")
          .where("UserId", isEqualTo: email)
          .get();
      if (brandSnapshot.docs.isNotEmpty) {
        return UserModel.fromSnapshot(brandSnapshot.docs.first);
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => SetProfileScreen(), arguments: email)
          : Get.offAll(() => const SignupScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.message);
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // firebaseUser.value != null
      //     ? Get.offAll(() => const DashboardScreen())
      //     : Get.offAll(() => const SignupScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.message);
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.to(LoginScreen());
      Get.snackbar("Signou", "User Logout Successfully");
    } catch (e) {
      Get.snackbar("Signou", "Erro Signing out $e");
    }
  }
}
