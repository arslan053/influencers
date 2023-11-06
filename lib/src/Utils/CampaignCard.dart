import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  final String image;
  final String title_text;
  final subtitle_text;
  const CampaignCard({Key? key, required this.image, required this.title_text, this.subtitle_text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListTile(
        textColor: Colors.black,
        leading: CircleAvatar(child: Image.asset(image ,fit: BoxFit.contain,),),
        title: Text(title_text),
        subtitle: Text(subtitle_text),
        trailing: Text('1h ago'),
        tileColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        
      ),
    );
  }
}