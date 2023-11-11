import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/CategoryCard.dart';
import 'package:influencer/src/Utils/CustomSearchbar.dart';
import 'package:influencer/src/Utils/InfluencerCard.dart';
import 'package:influencer/src/features/campaigns/views/create_campaign.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: (() {
              Get.to(CreateCampaign());
            }),
            child: Image.asset('assets/images/menu.png')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Find',
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: 32)),
                const SizedBox(
                  width: 4,
                ),
                Text('Influencer',
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        color: Color(0xFF75BD78),
                        fontSize: 32)),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomSearchField(),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories',
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: 16)),
                Text('See All',
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        color: Color(0xFF75BD78),
                        fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(
                      path: 'assets/images/celebrity.png', text: 'Celeberity'),
                  CategoryCard(
                      path: 'assets/images/lifestyle.png', text: 'LifeStyle'),
                  CategoryCard(
                      path: 'assets/images/fashion.png', text: 'Fashion'),
                  CategoryCard(path: 'assets/images/food.png', text: 'Food'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Influencers',
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        fontSize: 16)),
                Text('See All',
                    style: TextStyle(
                        fontFamily: GoogleFonts.ubuntu.toString(),
                        color: Color(0xFF75BD78),
                        fontSize: 16)),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InfluencerCard(
                        path: 'assets/images/influencer.png',
                        category: 'Fashion & lifeStyle',
                        rating: '4.5',
                        name: 'Emily Watson',
                        order: '63'),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
