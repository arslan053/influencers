import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/campaigns/model/campain_model.dart';

import '../controller/campaign_controller.dart';

class CreateCampaign extends StatefulWidget {
  CreateCampaign({Key? key}) : super(key: key);

  @override
  State<CreateCampaign> createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign> {
  final controller = Get.put(CampaignController());

  String selectedCategory = 'beauty';
  List<String> categories = []; // This list will hold your categories

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Call the method to fetch categories
  }

  Future<void> fetchCategories() async {
    // Fetch categories from Firestore and populate the 'categories' list
    // For example:
    var snapshot =
        await FirebaseFirestore.instance.collection('Categories').get();
    var fetchedCategories =
        snapshot.docs.map((doc) => doc['Category'] as String).toList();

    setState(() {
      categories = fetchedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Campaign",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // This line will navigate back
          },
        ),
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
                            width: 85,
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
                            width: 85,
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
                        "Select Category",
                        style: TextStyle(
                            fontFamily: GoogleFonts.ubuntu.toString(),
                            fontSize: smallSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          DropdownButton<String>(
                            value: selectedCategory,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: smallSize,
                                fontWeight: FontWeight.bold),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
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
                                category: selectedCategory,
                                status: "open",
                                createdAt: DateTime.now());
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
