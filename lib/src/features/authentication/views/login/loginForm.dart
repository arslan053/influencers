import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/authentication/controllers/signin_controller.dart';

import '../forget_password/forget_password_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
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
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.to(() => ForgotPassword());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: smallSize - 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        SigninController.instance.signinUser(
                            controller.email.text, controller.password.text);
                      }
                    },
                    child: const Text("Login"))),
          ],
        ));
  }
}
