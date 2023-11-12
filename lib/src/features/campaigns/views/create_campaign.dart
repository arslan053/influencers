import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/campaigns/model/campain_model.dart';

import '../controller/campaign_controller.dart';

class CreateCampaign extends StatelessWidget {
  CreateCampaign({Key? key}) : super(key: key);

  final controller = Get.put(CampaignController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Campaign",
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
                "Describe Your Offer",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: GoogleFonts.ubuntu.toString(),
                  fontSize: formHeight - 2,
                ),
              ),
              const SizedBox(
                height: paddingsmall - 2,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: controller.description,
                    maxLines: 7,
                    decoration: const InputDecoration(
                      hintText: "e.g delievery rquirenments timetable",
                      border: OutlineInputBorder(),
                    ),
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
                      Row(
                        children: [
                          Text(
                            "Rupees",
                            style: TextStyle(
                                fontFamily: GoogleFonts.ubuntu.toString(),
                                fontSize: smallSize - 5,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 70,
                            height: 35,
                            child: TextField(
                              controller: controller.totalPrice,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          )
                        ],
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
                        "Deliever Time",
                        style: TextStyle(
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontSize: smallSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Days",
                            style: TextStyle(
                                fontFamily: GoogleFonts.ubuntu.toString(),
                                fontSize: smallSize - 5,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 70,
                            height: 35,
                            child: Expanded(
                              child: TextField(
                                controller: controller.delieveryTime,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
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
                        "Expire in?",
                        style: TextStyle(
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontSize: smallSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Days",
                            style: TextStyle(
                                fontFamily: GoogleFonts.ubuntu.toString(),
                                fontSize: smallSize - 5,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 70,
                            height: 35,
                            child: TextField(
                              controller: controller.expireInDays,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
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
                      child: ElevatedButton(
                          onPressed: () {
                            final campaign = CampaignModel(
                                description: controller.description.text,
                                totalPrice: controller.totalPrice.text,
                                delieveryTime: controller.delieveryTime.text,
                                expireInDays: controller.expireInDays.text);
                            CampaignController.instance
                                .createCampaign(campaign);
                          },
                          child: Text("Launch")))
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
