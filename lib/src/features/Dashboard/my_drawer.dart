import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:influencer/src/features/campaigns/views/create_campaign.dart';
import 'package:influencer/src/features/profile/ProfileScreen.dart';

import '../../repository/authentication_repository/authentication_repository.dart';

Drawer MyDrawer() {
  final _authRepo = Get.put(AuthenticationRepository());

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
            currentAccountPicture: _authRepo.currentUser?.imageUrl != null &&
                    _authRepo.currentUser!.imageUrl!.isNotEmpty
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(_authRepo.currentUser!.imageUrl!),
                  )
                : CircleAvatar(
                    child: Text(
                      _authRepo.currentUser!.name.substring(0, 1),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
            accountName: Text(_authRepo.currentUser!.name),
            accountEmail: Text(_authRepo.currentUser!.name)),
        ListTile(
          title: const Text("Profile"),
          trailing: Icon(Icons.person),
          onTap: () {
            Get.to(ViewProfile());
          },
        ),
        ListTile(
          title: const Text("My Campaigns"),
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
