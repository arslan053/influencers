import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/authentication/views/login/login_screen.dart';
import 'package:influencer/src/features/authentication/views/signup/signup_screen.dart';
import 'package:influencer/src/features/authentication/views/set_profile/set_profile_screen.dart';
import 'package:influencer/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  _setIntialScreen(User? user) {
    Get.offAll(() => const LoginScreen());
    // user == null
    //     ? Get.offAll(() => const SignupScreen())
    //     : Get.offAll(() => const LoginScreen());
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setIntialScreen); // it is always ready to do action
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
      firebaseUser.value != null
          ? Get.offAll(() => const LoginScreen())
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
}
