import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';

import '../../../Utils/campaign_card.dart';
import '../../../repository/bid_repository/bid_repository.dart';
import '../../../repository/order_repository/order_repository.dart';
import '../../../repository/users_repository/influencer_repository.dart';
import '../../campaigns/model/campain_model.dart';
import '../model/bid_model.dart';
import 'bid_card.dart';

class MyCampaignBids extends StatelessWidget {
  CampaignModel campaign;

  MyCampaignBids({Key? key, required this.campaign}) : super(key: key);
  final bidRepository = Get.put(BidRepository());
  final orderRepository = Get.put(OrderRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF97CD9A),
        title: const Text('Bids'),
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
                child: StreamBuilder<List<Bid>>(
                  stream: bidRepository.getMyBidsAsStream(campaign.id!),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text("No bids available"));
                    } else if (snapshot.hasData) {
                      List<Bid> bids = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: bids.length,
                        itemBuilder: (BuildContext context, index) {
                          Bid bid = bids[index];
                          return FutureBuilder<ProfileModel>(
                            future: InfluencerRepository.instance
                                .getInfluencerDetails(bid.influencerId),
                            builder: (context, influencerSnapshot) {
                              if (influencerSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (influencerSnapshot.hasError) {
                                return Text(
                                    'Error: ${influencerSnapshot.error}');
                              } else if (influencerSnapshot.hasData) {
                                ProfileModel influencer =
                                    influencerSnapshot.data!;
                                return BidCard(
                                  title: influencer.name,
                                  subtitle: bid.remarks,
                                  imageUrl: influencer.imageUrl != null &&
                                          influencer.imageUrl!.isNotEmpty
                                      ? influencer.imageUrl
                                      : null,
                                  onButtonPressed2: () {
                                    bidRepository.deleteBid(bid.id!);
                                  },
                                  deliveryTime: bid.deliveryDays.toString(),
                                  orderAmount: bid.bidAmount.toString(),
                                  onButtonPressed1: () async {
                                    await orderRepository
                                        .createOrderFromBid(bid);
                                  },
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



//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: Column(
//           children: [
//             // ... other widget elements like headers ...

//             Expanded(
//               child: StreamBuilder<List<Bid>>(
//                 stream: bidRepository.getMyBidsAsStream(
//                     campaign.id!), // Replace with actual stream
//                 builder: (BuildContext context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text(snapshot.error.toString()));
//                   } else if (snapshot.hasData) {
//                     List<Bid> bids = snapshot.data ?? [];
//                     return ListView.builder(
//                       itemCount: bids.length,
//                       itemBuilder: (BuildContext context, index) {
//                         Bid bid = bids[index];
//                         return FutureBuilder<ProfileModel>(
//                           future: InfluencerRepository.instance
//                               .getInfluencerDetails(bid.influencerId),
//                           builder: (context, influencerSnapshot) {
//                             if (influencerSnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return CircularProgressIndicator();
//                             } else if (influencerSnapshot.hasError) {
//                               return Text('Error: ${influencerSnapshot.error}');
//                             } else if (influencerSnapshot.hasData) {
//                               ProfileModel influencer =
//                                   influencerSnapshot.data!;
//                               return ListTile(
//                                 leading: Image.network(influencer
//                                     .imageUrl!), // Replace with actual image URL
//                                 title: Text(influencer.name),
//                                 subtitle: Text(
//                                     'Bid Details...'), // Replace with actual bid details
//                                 // ... other UI elements ...
//                               );
//                             } else {
//                               return Text("No Influencer found");
//                             }
//                           },
//                         );
//                       },
//                     );
//                   } else {
//                     return Center(child: Text("No Bids found"));
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
