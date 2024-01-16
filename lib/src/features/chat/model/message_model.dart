import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String chatId;
  String senderId;
  String text;
  DateTime timestamp;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      chatId: data['chatId'],
      senderId: data['senderId'],
      text: data['text'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
