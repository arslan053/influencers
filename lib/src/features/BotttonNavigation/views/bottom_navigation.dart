import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influencer/src/features/Dashboard/dashboard_screen.dart';
import 'package:influencer/src/features/Wallet/views/WalletScreen.dart';
import 'package:influencer/src/features/order/views/my_orders.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../chat/views/message_screen.dart';
import '../../campaigns/views/campaign_screen.dart';
import '../../users_profile/controller/profile_controller.dart';
import '../../users_profile/model/user_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(ProfileController());
  final _authRepo = Get.put(AuthenticationRepository());
  ProfileModel? userData;
  late String uid;
  bool isLoading = true;
  int _currentIndex = 0;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    uid = _authRepo.firebaseUser.value!.uid;
    final userEmail = _authRepo.firebaseUser.value?.email;
    _loadUserData();
    // controller.getuserData();
  }

  Future<void> _loadUserData() async {
    String useruid = _authRepo.firebaseUser.value!.uid;
    try {
      var user = await controller.getAUser(useruid);
      // Assuming you have a method to convert raw user data to ProfileModel

      setState(() {
        userData = user;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      DashboardScreen(userModel: userData!),
      // Define your different views here
      const MessageScreen(),
      MyOrders(user: userData!),
      const WallettScreen(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green.shade200,
        unselectedItemColor: Colors.black26,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
        ],
      ),
    );
  }
}
