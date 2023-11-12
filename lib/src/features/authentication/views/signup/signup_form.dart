import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/authentication/controllers/signup_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: controller.name,
          decoration: const InputDecoration(
            hintText: "Name",
            prefixIcon: Icon(
              Icons.person,
              color: blackColor,
            ),
          ),
        ),
        const SizedBox(
          height: smallSize,
        ),
        TextFormField(
          controller: controller.username,
          decoration: const InputDecoration(
            hintText: "User Name",
            prefixIcon: Icon(
              Icons.person,
              color: blackColor,
            ),
          ),
        ),
        const SizedBox(
          height: smallSize,
        ),
        TextFormField(
          controller: controller.email,
          decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.email,
              color: blackColor,
            ),
          ),
        ),
        const SizedBox(
          height: smallSize,
        ),
        TextFormField(
          controller: controller.phonenumber,
          decoration: const InputDecoration(
            hintText: "Phone",
            prefixIcon: Icon(
              Icons.phone,
              color: blackColor,
            ),
          ),
        ),
        const SizedBox(
          height: smallSize,
        ),
        TextFormField(
          controller: controller.password,
          decoration: const InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(
              Icons.fingerprint,
              color: blackColor,
            ),
            suffixIcon: Icon(
              Icons.remove_red_eye_sharp,
              color: Colors.black,
            ),
          ),
        ),
        // Row(
        //   children: <Widget>[
        //     ListTile(title: Text("Influencer"),
        //   leading: Radio<SingingCharacter>(
        //     value: SingingCharacter.lafayette,
        //     groupValue: _character,
        //     onChanged: (SingingCharacter? value) {
        //       setState(() {
        //         _character = value;
        //       });
        //     },
        //     )
        //   ],
        // ),

        const SizedBox(
          height: smallSize - 10,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  SignupController.instance.registerUser(
                      controller.email.text.trim(), controller.password.text);
                },
                child: const Text("Sign Up"))),
        const SizedBox(
          height: smallSize,
        ),
      ],
    ));
  }
}
