import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/authentication/views/set_profile/set_profile_form.dart';

import '../../../../Utils/utils.dart';
import '../../../../constants/colors.dart';
import '../../controllers/set_profile_controller.dart';

class SetProfileScreen extends StatelessWidget {
  SetProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(SetProfileController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void selectImage() async {
      Uint8List img = await imagePick(ImageSource.gallery);
      controller.image.value = img;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(top: largeSize),
          child: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: smallSize),
              child: Stack(
                children: [
                  Obx(() {
                    return controller.image.value != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                MemoryImage(controller.image.value!),
                          )
                        : const CircleAvatar(
                            radius: largeSize,
                            backgroundColor: myPrimaryColor,
                            child: Icon(
                              Icons.person,
                              size: largeSize * 1.7,
                              color: Colors.white,
                            ),
                          );
                  }),
                  Positioned(
                    bottom: 0,
                    left: 80,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () {
                        selectImage();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: height * 0.72,
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: greycolor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(mediumlSize - 5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallSize),
                  child: Column(
                    children: const <Widget>[
                      SizedBox(
                        height: defaultSize,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: smallSize),
                      ),
                      ProfileSetupForm(),
                    ],
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
