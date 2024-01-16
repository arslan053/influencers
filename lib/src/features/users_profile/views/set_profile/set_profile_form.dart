import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/users_profile/controller/set_profile_controller.dart';
import 'package:influencer/src/features/users_profile/model/user_model.dart';
import 'package:influencer/src/repository/users_repository/influencer_repository.dart';
import '../../../../constants/colors.dart';

class ProfileSetupForm extends StatefulWidget {
  const ProfileSetupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileSetupForm> createState() => _ProfileSetupFormState();
}

class _ProfileSetupFormState extends State<ProfileSetupForm> {
  String? fcm_token;

  fcm_tokene() async {
    fcm_token = await FirebaseMessaging.instance.getToken();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fcm_tokene();
  }

  @override
  Widget build(BuildContext context) {
    print(fcm_token);
    final controller = Get.put(SetProfileController());
    final _formkey = GlobalKey<FormState>();
    return Expanded(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            controller: controller.name,
            decoration: const InputDecoration(
              hintText: "Name*",
            ),
          ),
          const SizedBox(
            height: buttonHeight - 2,
          ),
          TextFormField(
            controller: controller.username,
            decoration: const InputDecoration(
              hintText: "username*",
            ),
          ),
          const SizedBox(
            height: buttonHeight,
          ),
          TextFormField(
            controller: controller.website,
            decoration: const InputDecoration(
              hintText: "website",
            ),
          ),
          const SizedBox(
            height: buttonHeight,
          ),
          TextFormField(
            controller: controller.phonenumber,
            decoration: const InputDecoration(
              hintText: "phone number",
            ),
          ),
          const SizedBox(
            height: buttonHeight,
          ),
          TextFormField(
            controller: controller.bio,
            decoration: const InputDecoration(
              hintText: "Bio",
            ),
          ),
          const SizedBox(
            height: buttonHeight,
          ),
          TextFormField(
            controller: controller.description,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "About You*",
            ),
          ),
          const SizedBox(
            height: buttonHeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Radio<String>(
                          value: "influencer",
                          groupValue: controller.role.value,
                          onChanged: (value) {
                            controller.role.value = value!;
                          },
                        ),
                        const Text("Influencer"),
                      ],
                    ),
                    Column(children: [
                      Radio<String>(
                        value: "brand",
                        groupValue: controller.role.value,
                        onChanged: (value) {
                          controller.role.value = value!;
                        },
                      ),
                      const Text("Brand"),
                    ]),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: largeSize2 + 10,
                    child: ElevatedButton(
                        onPressed: () {
                          final influencer = ProfileModel(
                              name: controller.name.text.trim(),
                              username: controller.username.text,
                              email: Get.arguments.toString(),
                              phonenumber: controller.phonenumber.text,
                              website: controller.website.text,
                              bio: controller.bio.text,
                              description: controller.description.text,
                              rating: 0,
                              fcm_token: fcm_token.toString());
                          SetProfileController.instance.createUser(influencer,
                              controller.role.value, controller.image.value!);
                        },
                        child: const Text("Submit"))),
              )
            ],
          )
        ],
      )),
    );
  }
}
