import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/Page/home_page.dart';
import 'package:meditation_app/Page/meditate_page.dart';
import 'package:meditation_app/Page/music_page.dart';
import 'package:meditation_app/Page/sleep_page.dart';
import 'package:meditation_app/Page/user_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  int _selectIndex = SaveChange.indexPage;

  void _navigateBottombar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    const SleepPage(),
    const MeditatePage(),
    const HomePage(),
    const MusicPage(),
    const UserAfsarPage()
  ];

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor:_selectIndex == 0 ?const Color(0xFF1F265E): kColorLightGrey,
      body: SafeArea(child: _pages[_selectIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        
          height: 75,
          backgroundColor: _selectIndex == 0 ?const Color(0xFF1F265E): kColorLightGrey,
          color: Colors.white,
          onTap: _navigateBottombar,
          //animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: Duration(milliseconds: 400),
          index: _selectIndex,
          items: [
            Image.asset(
              'assets/images/ic_sleep.png',
            ),
            Image.asset(
              'assets/images/ic_water.png',
            ),
            Image.asset(
              'assets/images/ic_home.png',
            ),
            Image.asset(
              'assets/images/ic_music.png',
            ),
            Image.asset(
              'assets/images/ic_userafsar.png',
            ),
          ]),
          
    );
  }
}
// change switch and index page
class SaveChange {
  static List<bool> changeSwitch = [false, false];
  static int indexPage = 2;
}
