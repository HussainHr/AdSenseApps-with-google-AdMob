import 'package:ads_app_demo/banner_screen.dart';
import 'package:ads_app_demo/reewarded_ad_screen.dart';
import 'package:ads_app_demo/rewarded_interstitial_screen.dart';
import 'package:ads_app_demo/stream_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    RewardedScreen(),
    BannerScreen(),
    StreamAdScreen(),
    RewardedInterStitialScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewarded Ad Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
            ),
            label: 'Rewarded',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Banner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Stream',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Interstital',
          ),
        ],
      ),
    );
  }
}
