import 'package:flutter/material.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import 'package:influencer/src/features/users_profile/views/view_profile.dart';

import '../../Utils/inbox_card.dart';
// Import your models and other screens as necessary

class InfluencerListScreen extends StatelessWidget {
  final List<ProfileModel> influencers;

  InfluencerListScreen({Key? key, required this.influencers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Influencers"),
      ),
      body: ListView.builder(
        itemCount: influencers.length,
        itemBuilder: (context, index) {
          final influencer = influencers[index];
          return InkWell(
            onTap: () {
              // Navigate to the User Screen with the selected influencer's data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProfile(profile: influencer),
                ),
              );
            },
            child: Inboxcard(
              image: (influencer.imageUrl != null &&
                      influencer.imageUrl!.isNotEmpty)
                  ? influencer.imageUrl!
                  : '', // Assuming this is a field in your model
              name: influencer.name,
              subtitle_text:
                  influencer.description, // Replace with the actual field
            ),
          );
        },
      ),
    );
  }
}
