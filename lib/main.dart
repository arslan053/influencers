import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:influencer/src/constants/colors.dart';
import 'package:influencer/src/features/BotttonNavigation/bottomNavigation.dart';


void main() {
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
      home:  MyHomePage(),
    );
  }
}

