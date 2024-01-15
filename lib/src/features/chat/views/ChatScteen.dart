import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/chat/controllers/messages_controller.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';

class ChatScreen extends StatefulWidget {
  final ProfileModel user;
  ChatScreen({required this.user});
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final controller = Get.put(MessagesController());
  final TextEditingController _textController = TextEditingController();
  late final String _chatId;
  late final Query _messagesQuery;
  late final User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _chatId = MessagesController.instance
        .generateChatId(_user.uid, widget.user.userId!);
    print("Chat is is $_chatId");

    // Set up the query for messages
    _messagesQuery = FirebaseFirestore.instance
        .collection('Messages')
        .where('ChatId', isEqualTo: _chatId);
    // Assuming messages have a timestamp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesQuery.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                // If there are no documents, show a placeholder.
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }
                var messages = snapshot.data!.docs.reversed;

                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  var messageData = message.data() as Map<String, dynamic>;
                  var messageText = messageData['Text'] ??
                      ''; // Handle null or missing 'text'
                  var messageSender = messageData['SenderId'];

                  var isCurrentUser = messageSender ==
                      _user.uid; // Check if the current user is the sender

                  var messageWidget =
                      _buildMessage(messageSender, messageText, isCurrentUser);
                  messageWidgets.add(messageWidget);
                }

                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.amber),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: controller.message,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  print("calling the send message......");
                  MessagesController.instance.sendMessage(
                      widget.user.userId!, controller.message.text);
                }),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.isNotEmpty) {
      // Use your existing sendMessage function
      MessagesController.instance.sendMessage(widget.user.userId!, text);

      // Clear the text field
      controller.message.clear();
    }
  }

  Widget _buildMessage(String sender, String text, bool isCurrentUser) {
    return ListTile(
      title: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isCurrentUser ? Colors.black : Colors.black87,
            ),
            textAlign: isCurrentUser ? TextAlign.right : TextAlign.left,
          ),
        ),
      ),
      subtitle: Text(isCurrentUser ? 'You' : 'User $sender'),
    );
  }
}
