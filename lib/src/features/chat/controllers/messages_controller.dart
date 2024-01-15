import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  static MessagesController get instance => Get.find<MessagesController>();
  final message = TextEditingController();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String senderId;

  @override
  void onInit() {
    super.onInit();
    _initializeSenderId();
  }

  Future<void> _initializeSenderId() async {
    var user = await FirebaseAuth.instance.currentUser;
    senderId = user!.uid; // Assuming you need the user's UID
    update(); // If using GetBuilder or similar widgets
  }

  String generateChatId(String uid1, String uid2) {
    List<String> userIds = [uid1, uid2];
    userIds.sort();
    return userIds.join('_');
  }

  Future<void> sendMessage(String receiverId, String messageText) async {
    try {
      String chatId = generateChatId(senderId, receiverId);
      print("Message is ping ");

      var chatDocRef =
          FirebaseFirestore.instance.collection('Chats').doc(chatId);
      await chatDocRef.set({
        'Participants': [senderId, receiverId],
        'LastMessage': messageText,
        'LastMessageTime': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance.collection('Messages').add({
        'ChatId': chatId,
        'SenderId': senderId,
        'Text': messageText,
        'Timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
