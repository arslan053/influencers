import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/search/influencer_screen.dart';

import '../features/campaigns/model/campain_model.dart';
import '../features/search/campaign_list_screen.dart';
import '../features/users_profile/model/user_model.dart';

class CustomSearchField extends StatelessWidget {
  final ProfileModel? user; // Add this line

  // Update the constructor to require the currentUser
  CustomSearchField({Key? key, this.user}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  void handleSearch(BuildContext context, String value) async {
    List<ProfileModel> results = await searchInfluencers(value);
    Get.to(InfluencerListScreen(
      influencers: results,
    ));
  }

  void handleCampaignSearch(BuildContext context, String value) async {
    List<CampaignModel> results = await searchCampaigns(value);
    // Assuming you are using GetX for navigation and state management
    Get.to(CampaignListScreen(
      campaigns: results,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        // Set the width of the search field
        decoration: BoxDecoration(
          color: Colors.grey, // Background color
          borderRadius: BorderRadius.circular(8.0), // Border radius
        ),
        child: TextField(
          controller: controller,
          onSubmitted: (value) {
            if (user!.role == "Brand") {
              handleSearch(context, value);
            } else if (user!.role == "Influencer") {
              handleCampaignSearch(context, value);
            }
          },
          decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none, // No border
              contentPadding: EdgeInsets.all(16.0),
              // Padding inside the field
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.green.shade300),
                onPressed: () {
                  if (user!.role == "Brand") {
                    handleSearch(context, controller.value.text);
                  } else if (user!.role == "Influencer") {
                    handleCampaignSearch(context, controller.value.text);
                  }
                },
                color: Colors.green.shade300,
              )),
        ),
      ),
    );
  }

  Future<List<ProfileModel>> getAllInfluencers() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Influencers').get();

    List<ProfileModel> influencers = [];
    for (var doc in querySnapshot.docs) {
      ProfileModel influencer = ProfileModel.fromSnapshot(doc);
      influencers.add(influencer);
    }

    return influencers;
  }

  Future<List<ProfileModel>> searchInfluencers(String searchTerm) async {
    List<ProfileModel> allInfluencers = await getAllInfluencers();
    String searchLower = searchTerm.toLowerCase();

    return allInfluencers.where((influencer) {
      return influencer.name.toLowerCase().contains(searchLower);
    }).toList();
  }

  Future<List<CampaignModel>> getAllCampaigns() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Campaigns')
        .where('Status', isEqualTo: 'open') // Fetch only 'open' campaigns
        .get();

    List<CampaignModel> campaigns = [];
    for (var doc in querySnapshot.docs) {
      CampaignModel campaign = CampaignModel.fromSnapShot(doc);
      campaigns.add(campaign);
    }

    return campaigns;
  }

  Future<List<CampaignModel>> searchCampaigns(String searchTerm) async {
    List<CampaignModel> allOpenCampaigns = await getAllCampaigns();
    String searchLower = searchTerm.toLowerCase();

    return allOpenCampaigns.where((campaign) {
      bool descriptionMatches =
          campaign.description.toLowerCase().contains(searchLower);
      bool categoryMatches =
          campaign.category.toLowerCase().contains(searchLower);
      return descriptionMatches || categoryMatches;
    }).toList();
  }
}
