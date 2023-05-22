import 'package:flutter/material.dart';
import 'categories/categories.dart';
import 'profile/profile.dart';
import 'search/search.dart';
import 'store/store.dart';
import '../../constants/color.dart';
import 'cart/cart.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _pageIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    CategoriesScreen(),
    StoreScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void setNewPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_pageIndex],
    );
  }

}