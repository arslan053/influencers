import 'package:flutter/material.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/constants/sizes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
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
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
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
        const SizedBox(
          height: smallSize,
        ),
        const Align(
            alignment: Alignment.centerRight, child: Text("Forget Password")),
        const SizedBox(
          height: smallSize - 10,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: const Text("Login")))
      ],
    ));
  }
}
