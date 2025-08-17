

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hi/pages/Leage.dart';

import 'package:hi/pages/home.dart';
import 'package:hi/pages/path.dart';
import 'package:hi/pages/profile.dart';




class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;

  late Home HomePage;
  late Scoreboard order;
  late PathScreen path;
  late Profile profilePage;

  int currentTabIndex = 0;

  @override
  void initState(){
    HomePage = Home();
    order =Scoreboard();
  path = PathScreen();
    profilePage = Profile();

    pages = [HomePage,path, order ,profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 40,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.wallet,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}


