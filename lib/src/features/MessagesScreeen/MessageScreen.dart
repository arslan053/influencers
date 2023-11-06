import 'package:flutter/material.dart';
import 'package:influencer/src/Utils/CustomSearchbar.dart';
import 'package:influencer/src/Utils/InboxCard.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF97CD9A),
        title: Text('Messages'),
        centerTitle: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8.0),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                CustomSearchField(),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (
                    BuildContext context, index) {
                    return const Inboxcard(image: 'assets/images/celebrity.png', title_text: 'Emma' ,subtitle_text: 'Hello mam, hope you are good .I hava do',);
                  }
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}