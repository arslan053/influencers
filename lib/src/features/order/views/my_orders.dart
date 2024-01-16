import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/features/order/views/order_card.dart';
import 'package:influencer/src/repository/order_repository/order_repository.dart';
import 'package:influencer/src/repository/users_repository/brand_repository.dart';

import '../../../repository/users_repository/influencer_repository.dart';
import '../../deliever_order/views/show_order_deliever_dialogue.dart';
import '../../users_profile/model/user_model.dart';
import '../model/order_model.dart';

class MyOrders extends StatefulWidget {
  ProfileModel user;
  MyOrders({Key? key, required this.user}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final orderRepository = Get.put(OrderRepository());
  final brandRepository = Get.put(BrandRepository());
  final influencerRepository = Get.put(InfluencerRepository());
  int _rating = 0;

  @override
  void initState() {
    super.initState();
  }

  Stream<List<OrderModel>> executeFunctionBasedOnRole() {
    if (widget.user.role == 'Brand') {
      return orderRepository.getOrdersByBrandId(widget.user.userId!);
    } else {
      return orderRepository.getOrdersByInfluencerId(widget.user.userId!);
    }
  }

  Future<ProfileModel> getUserDetail() async {
    if (widget.user.role == 'Brand') {
      return brandRepository.getBrandDetails(widget.user.userId!);
    } else {
      return influencerRepository.getInfluencerDetails(widget.user.userId!);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF97CD9A),
        title: const Text('Orders'),
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
                child: StreamBuilder<List<OrderModel>>(
                  stream: executeFunctionBasedOnRole(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      List<OrderModel> orders = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, index) {
                          OrderModel order = orders[index];
                          return FutureBuilder<ProfileModel>(
                            future: getUserDetail(),
                            builder: (context, influencerSnapshot) {
                              if (influencerSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else if (influencerSnapshot.hasError) {
                                return Text(
                                    'Error: ${influencerSnapshot.error}');
                              } else if (influencerSnapshot.hasData) {
                                ProfileModel influencer =
                                    influencerSnapshot.data!;
                                return OrderCard(
                                  title: influencer.name,
                                  subtitle: order.remarks,
                                  imageUrl: influencer.imageUrl != null &&
                                          influencer.imageUrl!.isNotEmpty
                                      ? influencer.imageUrl
                                      : null,
                                  onButtonPressed2: () {
                                    showOrderDelieverDialogue(
                                      context,
                                    );
                                  },
                                  deliveryTime: order.deliveryDate.toString(),
                                  orderAmount: order.bidAmount.toString(),
                                  onButtonPressed1: () async {},
                                );

                                // CampaignCard(
                                //   image: influencer.imageUrl!,
                                //   title_text: bid.bidAmount
                                //       .toString(), // Ensure this is a String
                                //   subtitle_text: bid.deliveryDays.toString(),
                                //   category: campaign.category.isNotEmpty &&
                                //           campaign.category != null
                                //       ? campaign.category
                                //       : 'N/A',
                                // );
                              } else {
                                return Text("No Influencer found");
                              }
                            },
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
