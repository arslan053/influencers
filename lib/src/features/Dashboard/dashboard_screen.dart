import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/category_card.dart';
import 'package:influencer/src/Utils/custom_search_bar.dart';
import 'package:influencer/src/Utils/influencer_card.dart';
import 'package:influencer/src/features/Dashboard/my_drawer.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import '../../repository/authentication_repository/authentication_repository.dart';
import '../campaigns/views/selected_campaigns.dart';
import '../users_profile/controller/profile_controller.dart';
import '../users_profile/views/view_profile.dart';

class DashboardScreen extends StatefulWidget {
  ProfileModel userModel;
  DashboardScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.put(ProfileController());
  final _authRepo = Get.put(AuthenticationRepository());
  ProfileModel? userData;
  late String uid;
  bool isLoading = true;
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    uid = _authRepo.firebaseUser.value!.uid;
    final userEmail = _authRepo.firebaseUser.value?.email;
    // controller.getuserData();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> db;

    if (widget.userModel.role == 'Brand') {
      db = FirebaseFirestore.instance
          .collection('Influencers')
          .orderBy('Rating', descending: true)
          .snapshots();
    } else {
      db = FirebaseFirestore.instance
          .collection('Brands')
          .orderBy('Rating', descending: true)
          .snapshots();
    }

    final db_categories =
        FirebaseFirestore.instance.collection('Categories').get().asStream();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            title: Text("Prohunt"),
            // elevation: 0,
            // leading: InkWell(
            //     onTap: (() {
            //       Get.to(CreateCampaign());
            //     }),
            //     child: Image.asset('assets/images/menu.png')),
          ),
        ),
        drawer: FutureBuilder(
            future: controller.getAUser(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data is ProfileModel) {
                  ProfileModel user = snapshot.data as ProfileModel;
                  print("user data name ${user.name}");
                  return MyDrawer(user);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error.toString()} '),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 80)),
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
                      Text(
                          widget.userModel.role == 'Influencer'
                              ? 'Campaigns'
                              : 'Influencers',
                          style: TextStyle(
                              fontFamily: GoogleFonts.ubuntu.toString(),
                              color: const Color(0xFF75BD78),
                              fontSize: 32)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomSearchField(user: widget.userModel),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories',
                          style: TextStyle(
                              fontFamily: GoogleFonts.ubuntu.toString(),
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: db_categories,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        final data = snapshot.data?.docs;
                        return GestureDetector(
                          child: Container(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data!.length,
                              itemBuilder: (BuildContext context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(SelectedCampaigns(
                                      category: data[index]["Category"],
                                    ));
                                  },
                                  child: CategoryCard(
                                      path: data[index]['ImageUrl'],
                                      text: data[index]["Category"]),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    }),
                const SizedBox(
                  height: 11,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          widget.userModel.role == 'Influencer'
                              ? 'Top Brands'
                              : 'Top Influencers',
                          style: TextStyle(
                              fontFamily: GoogleFonts.ubuntu.toString(),
                              fontSize: 16)),
                      // Text('See All',
                      //     style: TextStyle(
                      //         fontFamily: GoogleFonts.ubuntu.toString(),
                      //         color: Color(0xFF75BD78),
                      //         fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: db,
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Handle the loading state
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Handle the error state
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Data is ready
                      final data = snapshot
                          .data?.docs; // Explicitly cast to QuerySnapshot
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
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  final documentSnapshot = document
                                      as DocumentSnapshot<Map<String, dynamic>>;
                                  final profileModel =
                                      ProfileModel.fromSnapshot(
                                          documentSnapshot);
                                  Get.to(
                                      () => ViewProfile(profile: profileModel));
                                },
                                child: InfluencerCard(
                                  path: document?['ImageUrl'] ?? '',
                                  category: document?['Role'] ?? "",
                                  rating: '4.5',
                                  name: document?['Name'] ?? "",
                                  order: document?["Role"],
                                ),
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
          ),
        ));
  }
}
