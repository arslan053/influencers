import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/features/admin/views/category_Show_dialog.dart';

import '../../../Utils/category_card.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            ShowDialog(context);
          }),
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: height * 0.4,
                color: Colors.black.withOpacity(0.8),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      SizedBox(
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
                        children: const [
                          Text(
                            "Register Brands",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.4,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          child: const CategoryCard(
                              height: 120,
                              width: 120,
                              path: 'assets/images/celebrity.png',
                              text: 'Celeberity'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
