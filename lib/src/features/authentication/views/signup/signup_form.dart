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
    final _formkey = GlobalKey<FormState>();
    return Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.email,
                ),
              ),
            ),
            const SizedBox(
              height: smallSize,
            ),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.fingerprint,
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye_sharp,
                ),
              ),
            ),
            const SizedBox(
              height: smallSize,
            ),
            const SizedBox(
              height: smallSize - 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      SignupController.instance.registerUser(
                          controller.email.text.trim(),
                          controller.password.text);
                    },
                    child: const Text("Signup"))),
          ],
        ));
  }
}
