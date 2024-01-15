import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String chatId;
  List<String> participants;
  String lastMessage;
  DateTime lastMessageTime;
  // DateTime createdAt;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    // required this.createdAt,
  });

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      chatId: doc.id,
      participants: List<String>.from(data['Participants']),
      lastMessage: data['LastMessage'] ?? '',
      lastMessageTime: (data['LastMessageTime'] as Timestamp).toDate(),
      // createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
