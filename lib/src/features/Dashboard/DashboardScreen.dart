import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/CategoryCard.dart';
import 'package:influencer/src/Utils/CustomSearchbar.dart';
import 'package:influencer/src/Utils/InfluencerCard.dart';
import 'package:influencer/src/features/Dashboard/my_drawer.dart';
import 'package:influencer/src/features/authentication/model/user_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final db =  FirebaseFirestore.instance.collection('Influencers').get().asStream();
    dynamic user;
    Future<void> fetchData() async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc('userId'); // Replace 'userId' with the actual user ID
  final userSnapshot = await userDoc.get();
   user = UserModel.fromSnapshot(userSnapshot); // Rest of your code using the 'user' object
}

     @override
  void initState() {
    super.initState();
    fetchData();
  }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          // elevation: 0,
          // leading: InkWell(
          //     onTap: (() {
          //       Get.to(CreateCampaign());
          //     }),
          //     child: Image.asset('assets/images/menu.png')),
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
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  stream: db,
  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Handle the loading state
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      // Handle the error state
      return Text('Error: ${snapshot.error}');
    } else {
      // Data is ready
      final data = snapshot.data?.docs; // Explicitly cast to QuerySnapshot
      return Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data?.length,
          itemBuilder: (BuildContext context, index) {
            // Use data[index] to access individual documents
            final document = data?[index];
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: InfluencerCard(
                path: document?['ImageUrl'],
                category: document?['Role'],
                rating: '4.5',
                name: document?['Name'],
                order: '63',
              ),
            );
          },
        ),
      );
    }
  },
)

        ],
      ),
    );
  }
}
