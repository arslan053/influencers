import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/Utils/custom_search_bar.dart';
import 'package:influencer/src/Utils/inbox_card.dart';
import 'package:influencer/src/features/chat/controllers/chats_controller.dart';
import 'package:influencer/src/features/chat/views/ChatScteen.dart';
import 'package:influencer/src/features/users_profile/controller/profile_controller.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';

import '../../users_profile/model/user_model.dart';
import '../model/chat_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final profileController = Get.put(ProfileController());

  Future<ProfileModel?> getotherUser(String otherUserUid) async {
    return await profileController.getAUser(otherUserUid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF97CD9A),
        title: Text('Messages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: StreamBuilder<List<ChatModel>>(
                      stream: ChatsController.instance.getUserChats(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (!snapshot.hasData) {
                          return Text('No chats available');
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) {
                              var chat = snapshot.data![index];
                              String currentUserUid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              String otherUserUid = ChatsController.instance
                                  .getOtherParticipantId(
                                      chat.participants, currentUserUid);

                              return FutureBuilder<ProfileModel?>(
                                  future: getotherUser(otherUserUid),
                                  builder: (context, userSnapshot) {
                                    if (userSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child:
                                              CircularProgressIndicator()); // Or some placeholder
                                    }

                                    if (userSnapshot.hasError) {
                                      return Text(
                                          'Error: ${userSnapshot.error}');
                                    }

                                    if (!userSnapshot.hasData) {
                                      return Text('User Chat not available');
                                    }
                                    ProfileModel? otherUserDetails =
                                        userSnapshot.data;
                                    return GestureDetector(
                                      onTap: (() {
                                        if (otherUserDetails != null) {
                                          Get.to(ChatScreen(
                                              user: otherUserDetails));
                                        }
                                      }),
                                      child: Inboxcard(
                                          image: (otherUserDetails!.imageUrl !=
                                                      null &&
                                                  otherUserDetails!
                                                      .imageUrl!.isNotEmpty)
                                              ? otherUserDetails!.imageUrl!
                                              : '',
                                          name: otherUserDetails!.name,
                                          subtitle_text: chat.lastMessage),
                                    );
                                  });
                            });
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
