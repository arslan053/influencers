import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:influencer/src/features/campaigns/views/create_campaign.dart';
import 'package:influencer/src/features/users_profile/views/view_profile.dart';

import '../../repository/authentication_repository/authentication_repository.dart';
import '../campaigns/views/selected_campaigns.dart';
import '../order/views/my_orders.dart';
import '../users_profile/model/user_model.dart';

Drawer MyDrawer(ProfileModel userData) {
  final _authRepo = Get.put(AuthenticationRepository());

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
            // currentAccountPicture: CircleAvatar(
            //   radius: 65,
            //   child: CircleAvatar(
            //       radius: 65,
            //       child: CircleAvatar(
            //         child: Icon(Icons.person),
            //       )),
            // ),
            currentAccountPicture:
                userData.imageUrl != null && userData.imageUrl!.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(userData.imageUrl!),
                      )
                    : CircleAvatar(
                        child: Text(
                          _authRepo.currentUser!.name.substring(0, 1),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
            accountName: Text(userData.name ?? ''),
            accountEmail: Text(userData.email ?? '')),
        ListTile(
          title: const Text("Profile"),
          trailing: Icon(Icons.person),
          onTap: () {
            Get.to(ViewProfile(profile: userData));
          },
        ),
        ListTile(
          title: const Text("My Order"),
          trailing: Icon(Icons.speaker_sharp),
          onTap: () {
            Get.to(MyOrders(
              user: userData,
            ));
          },
        ),
        ListTile(
          title: const Text("My Campaigns"),
          trailing: Icon(Icons.speaker_sharp),
          onTap: () {
            Get.to(SelectedCampaigns());
          },
        ),
        ListTile(
          title: const Text("Campaigns"),
          trailing: Icon(Icons.speaker_sharp),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Create Campaign"),
          trailing: Icon(Icons.speaker_sharp),
          onTap: () {
            Get.to(CreateCampaign());
          },
        ),
        ListTile(
          title: Text("Logout"),
          onTap: () => _authRepo.signOut(),
        )
      ],
    ),
  );
}
