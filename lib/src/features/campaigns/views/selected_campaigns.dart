import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/campaign_card.dart';
import '../../../repository/campaign_repository.dart/campaign_repository.dart';
import '../../users_profile/model/user_model.dart';
import '../model/campain_model.dart';
import 'campaign_detail.dart';

class SelectedCampaigns extends StatefulWidget {
  final String? category;

  const SelectedCampaigns({Key? key, this.category}) : super(key: key);

  @override
  State<SelectedCampaigns> createState() => _SelectedCampaignsState();
}

class _SelectedCampaignsState extends State<SelectedCampaigns> {
  bool get isCategoryPresent => widget.category != null;

  Stream<List<CampaignModel>> _selectedCampaignsStream() {
    if (isCategoryPresent) {
      return CampaignRepository.instance
          .getCampaignsByCategory(widget.category!);
    } else {
      return CampaignRepository.instance.getAllCampaignsAsStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF97CD9A),
        title: const Text('Campaigns'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
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
                  // Text(
                  //   'Filters',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontFamily: GoogleFonts.ubuntu.toString(),
                  //       fontSize: 15),
                  // )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<CampaignModel>>(
                  stream: _selectedCampaignsStream(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      List<CampaignModel> campaigns = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: campaigns.length,
                        itemBuilder: (BuildContext context, index) {
                          CampaignModel campaign = campaigns[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => CampaignDetails(campaign: campaign));
                            },
                            child: CampaignCard(
                              image: 'assets/images/celebrity.png',
                              title_text: campaign.description
                                  .toString(), // Ensure this is a String
                              subtitle_text: campaign.totalPrice,
                              category: campaign.category.isNotEmpty &&
                                      campaign.category != null
                                  ? campaign.category
                                  : 'N/A',
                            ),
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
