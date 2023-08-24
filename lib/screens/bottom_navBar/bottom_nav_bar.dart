import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cart_screen/cart_screen.dart';
import 'package:grocery_app/screens/favourite/favourite_screen.dart';
import 'package:grocery_app/screens/home/home.dart';
import 'package:grocery_app/screens/profile/profile_screen.dart';

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
            FavouriteScreen(),
            ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.purpleAccent.withOpacity(0.4),
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
              title:  Text('Cart'),
              icon:  Icon(Icons.shopping_cart)
          ),
          BottomNavyBarItem(
              activeColor: Colors.black,
              title:  Text('Orders'),
              icon:  Icon(Icons.newspaper_outlined,)
          ),
          BottomNavyBarItem(
              activeColor: Colors.black,
              title:  Text('Profile'),
              icon:  Icon(Icons.person,)
          ),
        ],
      ),
    );
  }
}
