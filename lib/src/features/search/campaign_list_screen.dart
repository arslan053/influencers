import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/campaign_card.dart';
import '../campaigns/model/campain_model.dart';
import '../campaigns/views/campaign_detail.dart';

class CampaignListScreen extends StatelessWidget {
  final List<CampaignModel> campaigns;

  CampaignListScreen({Key? key, required this.campaigns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Campaigns")),
      body: ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          CampaignModel campaign = campaigns[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => CampaignDetails(campaign: campaign));
            },
            child: CampaignCard(
              image: "",
              title_text:
                  campaign.description, // Assuming 'description' is a String
              subtitle_text:
                  campaign.totalPrice.toString(), // Convert to String if needed
              category:
                  campaign.category.isNotEmpty ? campaign.category : 'N/A',
            ),
          );
        },
      ),
    );
  }
}
