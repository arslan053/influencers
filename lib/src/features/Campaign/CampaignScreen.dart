import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/CampaignCard.dart';
import 'package:influencer/src/Utils/CustomSearchbar.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const  Color(0XFF97CD9A),
        title:const  Text('Promotions'),
        centerTitle: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8.0),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                CustomSearchField(),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Recent Campaigns',style: TextStyle(fontWeight: FontWeight.w600,fontFamily: GoogleFonts.ubuntu.toString(),fontSize: 15),),
                   Text('Filters',style: TextStyle(fontWeight: FontWeight.w600,fontFamily: GoogleFonts.ubuntu.toString(),fontSize: 15),)
                ],),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (
                    BuildContext context, index) {
                    return const CampaignCard(image: 'assets/images/celebrity.png',
                    title_text: 'Brand Promotion' ,
                    subtitle_text: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal ',);
                  }
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}