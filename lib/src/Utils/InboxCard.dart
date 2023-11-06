import 'package:flutter/material.dart';

class Inboxcard extends StatelessWidget {
  final String image;
  final String title_text;
  final subtitle_text;
  const Inboxcard({Key? key, required this.image, required this.title_text, this.subtitle_text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Image.asset(image ,fit: BoxFit.fill,),),
      title: Text(title_text),
      subtitle: Text(subtitle_text),
      
    );
  }
}