import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/bids/views/my_campaigns_bids.dart';
import 'package:influencer/src/features/bids/views/show_bid_dialogue.dart';
import 'package:influencer/src/features/campaigns/model/campain_model.dart';

import '../controller/campaign_controller.dart';

class CampaignDetails extends StatelessWidget {
  CampaignModel campaign;
  CampaignDetails({Key? key, required this.campaign}) : super(key: key);
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Campaign",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingmedium - 5),
          child: Container(
            height: height,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: largeSize,
              ),
              Text(
                "Description",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: GoogleFonts.ubuntu.toString(),
                  fontSize: formHeight - 2,
                ),
              ),
              const SizedBox(
                height: paddingsmall - 2,
              ),
              Text(
                campaign.description,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: largeSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: smallSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${campaign.totalPrice} Rupees",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: smallSize - 5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: paddingmedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Deliever Time",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: smallSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${campaign.delieveryTime} Days",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: smallSize - 5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: paddingmedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: smallSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        campaign.category,
                        style: TextStyle(
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontSize: smallSize,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: mediumlSize,
              ),
              Container(
                  width: double.infinity,
                  child: userUid == campaign.brandId
                      ? ElevatedButton(
                          onPressed: () {
                            Get.to(MyCampaignBids(campaign: campaign));
                          },
                          child: Text("Show Bids"))
                      : ElevatedButton(
                          onPressed: () {
                            ShowBidDialogue(context, campaign.id!, userUid);
                          },
                          child: Text("Bid")))
            ]),
          ),
        ),
      ),
    );
  }
}
