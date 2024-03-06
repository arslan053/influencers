import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:influencer/src/features/authentication/views/signup/signup_screen.dart';

import '../../../../Utils/round_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black26,
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.05,
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.03,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      // labelText: 'Email',
                      contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                      hintText: 'Enter Your Registered Email',
                      prefixIcon: Icon(Icons.email, color: Color(0xff203c61)),
                      hintStyle: TextStyle(color: Colors.grey),
                      errorStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    // Check if this field is empty
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email address';
                    }

                    // using regular expression
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    // the email is valid
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.01,
            ),
            RoundButton(
              title: 'Reset Password',
              buttonColor: const Color(0xff1d093e),
              width: mediaQuery.size.height * 0.25,
              onPress: () {
                auth
                    .sendPasswordResetEmail(
                        email: emailController.text.toString())
                    .then((value) {
                  Get.snackbar("",
                      "We have sent email to recover password,please check email",
                      snackPosition: SnackPosition.TOP,
                      colorText: Colors.green);
                  Get.to(SignupScreen());
                }).onError((error, stackTrace) {
                  Get.snackbar(error.toString(), error.toString(),
                      snackPosition: SnackPosition.TOP, colorText: Colors.red);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
