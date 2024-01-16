import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:influencer/firebase_options.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/features/authentication/views/login/login_screen.dart';
import 'package:influencer/src/repository/authentication_repository/authentication_repository.dart';
import 'src/features/chat/controllers/chats_controller.dart';
import 'src/repository/campaign_repository.dart/campaign_repository.dart';
import 'src/repository/users_repository/brand_repository.dart';
import 'src/repository/users_repository/influencer_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey =
  //     "pk_test_51OYyFwCco8aRIMxYG6XkLSTzibUuHt1nmcJYX3ddeN9IGGt6K6wZjlzA21X38kQgDPfm38IfRK9phsMfVaBF3m7j00qiDdnTji";
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  await FirebaseAppCheck.instance.activate();

  await FirebaseAppCheck.instance.activate();
  Get.put(InfluencerRepository());
  Get.put(BrandRepository());
  Get.put(AuthenticationRepository());
  Get.put(CampaignRepository());
  Get.put(ChatsController());

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
          primarySwatch: const MaterialColor(
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
      home: LoginScreen(),
    );
  }
}
