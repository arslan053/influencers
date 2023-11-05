import 'package:flutter/material.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/constants/sizes.dart';
import 'package:influencer/src/features/authentication/views/login/loginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            children: [
              const Icon(
                Icons.access_alarm,
                size: mediumContanerSize - 100,
              ),
              const SizedBox(
                height: mediumlSize,
              ),
              Container(
                  height: largeContainerSize,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(mediumlSize - 5)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: defaultSize,
                      ),
                      Text("Login",
                          style: Theme.of(context).textTheme.headline3),
                      const SizedBox(
                        height: mediumlSize,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: smallSize),
                        child: LoginForm(),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
