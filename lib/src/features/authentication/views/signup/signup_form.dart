import 'package:flutter/material.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/constants/sizes.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
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
            child:
                ElevatedButton(onPressed: () {}, child: const Text("Sign Up"))),
        const SizedBox(
          height: smallSize,
        ),
        Text("Already have Account? Login"),
      ],
    ));
  }
}
