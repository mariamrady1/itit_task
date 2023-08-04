import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mariamproject/view/main_screens/my_profile.dart';
import 'package:mariamproject/view/main_screens/products.dart';
import 'package:mariamproject/view/main_screens/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.green,
        activeColor: Colors.yellow,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        icons: const [
          Icons.home_filled,
          Icons.person,
          Icons.settings,
        ],
        activeIndex: index,
        onTap: (value){
          setState(() {
            index = value ;
          });
        },
      ),
      body: (index == 0) ? const Products() : (index == 1) ? const MyProfile() : const Setting(),
    );
  }
}
