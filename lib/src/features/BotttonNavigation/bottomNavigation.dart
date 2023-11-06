import 'package:flutter/material.dart';
import 'package:influencer/src/features/Campaign/CampaignScreen.dart';
import 'package:influencer/src/features/Dashboard/DashboardScreen.dart';
import 'package:influencer/src/features/MessagesScreeen/MessageScreen.dart';
import 'package:influencer/src/features/Wallet/WalletScreen.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    // Define your different views here
    MessageScreen(),
    CampaignScreen(),
    WallettScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green.shade200,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Campaign',
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
