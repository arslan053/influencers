import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/authentication/views/login/login_screen.dart';
import 'package:influencer/src/features/authentication/views/signup/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: myPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: largeSize + 10,
              ),
              Container(
                  height: size.height * 0.8,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(mediumlSize - 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: smallSize),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: defaultSize,
                        ),
                        Text("SignUP",
                            style: Theme.of(context).textTheme.headline3),
                        const SizedBox(
                          height: mediumlSize,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: smallSize),
                        ),
                        SignupForm(),
                        const SizedBox(
                          height: mediumlSize,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text("Alredy have account? Signin"),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
