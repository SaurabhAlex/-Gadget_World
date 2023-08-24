import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cart_screen/cart_screen.dart';
import 'package:grocery_app/screens/favourite/favourite_screen.dart';
import 'package:grocery_app/screens/home/home.dart';
import 'package:grocery_app/screens/profile/profile_screen.dart';

import '../order_screen/order_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            HomeScreen(),
            CartScreen(),
            OrderScreen(),
            ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: const Color(0xffc94810).withOpacity(0.6),
        iconSize: 27,

        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: Colors.black,
              title:  Text('Home'),
              icon:  Icon(Icons.home)
          ),
          BottomNavyBarItem(
              activeColor: Colors.black,
              title:  const Text('Cart'),
              icon:  const Icon(Icons.shopping_cart)
          ),
          BottomNavyBarItem(
              activeColor: Colors.black,
              title:  const Text('Orders'),
              icon:  const Icon(Icons.reorder,)
          ),
          BottomNavyBarItem(
              activeColor: Colors.black,
              title:  const Text('Profile'),
              icon:  const Icon(Icons.person,)
          ),
        ],
      ),
    );
  }
}
