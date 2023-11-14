import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 55.0,
      color: Colors.blueAccent,
      backgroundColor: Colors.lightBlue,
      animationDuration: Duration(
        milliseconds: 150,
      ),

      //animationCurve: Curves.bounceInOut,
      items: <Widget>[
        Icon(Icons.home, size: 35),
        Icon(Icons.format_list_bulleted, size: 35),
        Icon(Icons.account_circle_outlined, size: 35),
      ],
      onTap: (index) {
        //Handle button tap
      },
    );
  }
}
