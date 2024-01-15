import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/chat_model.dart';

class ChatsController extends GetxController {
  static ChatsController get instance => Get.find<ChatsController>();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  //  firebaseUser = await Rx<User?>(_auth.currentUser);

  // Rxn<String> currentUserId = Rxn<String>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   _auth.authStateChanges().listen(_authStateChanged);
  // }

  // void _authStateChanged(User? user) {
  //   if (user == null) {
  //     currentUserId.value = null;
  //   } else {
  //     currentUserId.value = user.uid;
  //   }
  // }

  Stream<List<ChatModel>> getUserChats() {
    var user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    print("yuyuiuytiuytuiouiyio$uid");

    return _db
        .collection('Chats')
        .where('Participants', arrayContains: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList());
  }

  String getOtherParticipantId(
      List<String> participants, String currentUserId) {
    return participants.firstWhere((id) => id != currentUserId,
        orElse: () => '');
  }
}
