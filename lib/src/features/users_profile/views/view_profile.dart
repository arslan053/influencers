import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/profile_card.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';
import '../../chat/views/ChatScteen.dart';

class ViewProfile extends StatelessWidget {
  final ProfileModel profile;
  const ViewProfile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authRepo = Get.put(AuthenticationRepository());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                // child: CircleAvatar(
                //     radius: 45,
                //     child: CircleAvatar(
                //       child: Icon(Icons.person),
                //     )),
                child: profile.imageUrl != null && profile.imageUrl!.isNotEmpty
                    ? CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          profile.imageUrl!,
                        ),
                      )
                    : CircleAvatar(
                        radius: 45,
                        child: Text(
                          profile.name.substring(0, 1),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    profile.name ?? "Notfound",
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Fasion & Lifestyle',
                    style: TextStyle(
                      color: Color(0xFF7F8080),
                      fontSize: 10,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Align(
              //     alignment: Alignment.bottomLeft,
              //     child: Text(
              //       'Instagram Insight',
              //       style: TextStyle(
              //           fontFamily: GoogleFonts.ubuntu.toString(),
              //           fontSize: 18,
              //           fontWeight: FontWeight.w600),
              //     )),
              // const SizedBox(
              //   height: 8,
              // ),
              // const ProfileCard(),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'About User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const SizedBox(
                width: 335,
                height: 46,
                child: Text(
                  "kamal@gmail.con",
                  // 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using le English.',
                  style: TextStyle(
                    color: Color(0xFF7F8080),
                    fontSize: 10,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '46 Reviews',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '4.8',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                padding: EdgeInsets.all(16.0),
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: Container(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/images/celebrity.png')),
                        title: const Text(
                          'Emily Watson',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        subtitle: const Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters',
                          style: TextStyle(
                            color: Color(0xFF7F8080),
                            fontSize: 10,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '4.8',
                              style: TextStyle(
                                // color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 10,
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChatScreen(user: profile));
        },
        child: Icon(Icons.message_rounded),
      ),
    );
  }
}

// FutureBuilder<List<ReviewModel>>(
//     future: fetchReviews(), // your function to fetch reviews
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator(); // Show a loading indicator
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}'); // Show error message
//       } else if (snapshot.hasData) {
//         // Data is fetched successfully, build the list
//         return ListView.builder(
//           itemCount: snapshot.data!.length, // Use the length of received data
//           itemBuilder: (context, index) {
//             ReviewModel review = snapshot.data![index];
//             return ListTile(
//               leading: Container(
//                 height: 30,
//                 width: 30,
//                 child: Image.asset('assets/images/celebrity.png'),
//               ),
//               title: Text(review.title), // Replace with actual data fields
//               subtitle: Text(review.description), // Replace with actual data fields
//               // Add other data presentation logic here
//             );
//           },
//         );
//       } else {
//         return Text('No reviews found'); // Handle the case of no data
//       }
//     },