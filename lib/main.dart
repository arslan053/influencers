import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/firebase_options.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';

import 'src/features/authentication/views/set_profile/set_profile_screen.dart';
import 'src/features/authentication/views/signup/signup_screen.dart';
import 'src/repository/influencer_repository/influencer_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  Get.put(InfluencerRepository());
  Get.put(AuthenticationRepository());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: MaterialColor(
            0xFF77BC7B,
            <int, Color>{
              50: myPrimaryColor,
              100: myPrimaryColor,
              200: myPrimaryColor,
              300: myPrimaryColor,
              400: myPrimaryColor,
              500: myPrimaryColor,
              600: myPrimaryColor,
              700: myPrimaryColor,
              800: myPrimaryColor,
              900: myPrimaryColor,
            },
          ),
          secondaryHeaderColor: Colors.black),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: SignupScreen(),
    );
  }
}
