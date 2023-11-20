import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/campaign_card.dart';
import 'package:influencer/src/Utils/custom_search_bar.dart';
import 'package:influencer/src/features/campaigns/model/campain_model.dart';
import 'package:influencer/src/repository/campaign_repository.dart/campaign_repository.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  // final campaignsData = CampaignRepository.instance.getAllCampaignsAsStream();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF97CD9A),
        title: const Text('Promotions'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              CustomSearchField(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Campaigns',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: 15),
                  ),
                  Text(
                    'Filters',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<CampaignModel>>(
                  stream: CampaignRepository.instance.getAllCampaignsAsStream(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Handle the error state
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      // Handle the data state
                      List<CampaignModel> campaigns = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: campaigns.length,
                        itemBuilder: (BuildContext context, index) {
                          CampaignModel campaign = campaigns[index];
                          return CampaignCard(
                            image: 'assets/images/celebrity.png',
                            title_text:
                                campaign.totalPrice, // Ensure this is a String
                            subtitle_text:
                                'Your static or dynamic subtitle text here',
                          );
                        },
                      );
                    } else {
                      // Handle the case where there is no error, no data, and not waiting
                      return Center(child: Text("No Campaigns found"));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                 stream: db_categories,
//                 builder: (BuildContext context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text(snapshot.error.toString());
//                   } else {
//                     final data = snapshot.data?.docs;
//                     return Container(
//                       height: 120,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: data!.length,
//                         itemBuilder: (BuildContext context, index) {
//                           return CategoryCard(
//                               path: data[index]['ImageUrl'],
//                               text: data[index]["Category"]);
//                         },