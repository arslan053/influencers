import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/features/admin/controller.dart';
import 'package:influencer/src/features/admin/views/category_Show_dialog.dart';

import '../../../Utils/category_card.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../authentication/views/login/login_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int brandCount = 0;
  Future<int> getBrandCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            'Brands') // Replace 'Brands' with the actual name of your collection
        .get();
    setState(() {
      brandCount = querySnapshot.docs.length;
    });
    return brandCount;
  }

  @override
  void initState() {
    super.initState();
    getBrandCount();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final controller = Get.put(AdminController());
    final controller_length = controller.getBrandCount();
    final db_categories =
        FirebaseFirestore.instance.collection('Categories').get().asStream();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            // try {
            //   await FirebaseAuth.instance.signOut();
            //   Get.to(LoginScreen());
            //   Get.snackbar("Signou", "User Logout Successfully");
            // } catch (e) {
            //   Get.snackbar("Signou", "Error Signing out $e");
            // }
            ShowDialog(context);
          }),
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.4,
              color: Colors.black.withOpacity(0.8),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Here is your analytics",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: whiteColor),
                    ),
                    const SizedBox(
                      height: mediumlSize,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Register Influencers",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                        Text(
                          "12",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: smallSize + 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Register Brands",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                        Text(
                          brandCount.toString(),
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: smallSize + 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Active Order",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                        Text(
                          "15",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: smallSize + 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Net Income",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                        Text(
                          "40k",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: smallSize + 15,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: smallSize - 10,
            ),
            const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(
              height: smallSize - 10,
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height * 0.4,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                child: CategoryCard(
                                    height: 110,
                                    width: 110,
                                    path: data[index]['ImageUrl'],
                                    text: data[index]['Category']),
                              );
                            }),
                        // child: ListView(
                        //   scrollDirection: Axis.vertical,
                        //   children: const [
                        //     CategoryCard(
                        //         path: 'assets/images/celebrity.png',
                        //         text: 'Celeberity'),
                        //     CategoryCard(
                        //         path: 'assets/images/lifestyle.png',
                        //         text: 'LifeStyle'),
                        //     CategoryCard(
                        //         path: 'assets/images/fashion.png', text: 'Fashion'),
                        //     CategoryCard(
                        //         path: 'assets/images/food.png', text: 'Food'),
                        //   ],
                        // ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
