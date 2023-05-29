import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/constants/color.dart';
import 'package:shoes_shop_admin/helpers/screen_size.dart';
import 'package:shoes_shop_admin/resources/styles_manager.dart';
import 'package:shoes_shop_admin/views/main/main_screen.dart';

import '../../resources/font_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // single gridView Item
    Widget buildDashboardItem({
      required String title,
      required int value,
      required Color color,
      required IconData icon,
      required int index,
    }) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          title,
                          style: getMediumStyle(
                            fontSize: FontSize.s16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(
                        value.toString(),
                        style: getBoldStyle(
                          fontSize: FontSize.s30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(icon, color: accentColor),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MainScreen(index: index),
                  ),
                ),
                child: Text(
                  'view more',
                  style: getRegularStyle(color: accentColor),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black12, bgColor],
              begin: Alignment.topCenter,
              end: Alignment.center,
              stops: [1, 30],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  final screenWidth = constraints.maxWidth;
                  const desiredItemWidth = 180.0;
                  final crossAxisCount =
                      (screenWidth / desiredItemWidth).floor();

                  return GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: crossAxisCount,
                    children: [
                      buildDashboardItem(
                        title: 'Orders',
                        value: 10,
                        color: dashBlue,
                        icon: Icons.shopping_cart_checkout,
                        index: 2,
                      ),
                      buildDashboardItem(
                        title: 'Cash Outs',
                        value: 15,
                        color: dashGrey,
                        icon: Icons.monetization_on,
                        index: 6,
                      ),
                      buildDashboardItem(
                        title: 'Products',
                        value: 8,
                        color: dashOrange,
                        icon: Icons.shopping_bag,
                        index: 1,
                      ),
                      buildDashboardItem(
                        title: 'Vendors',
                        value: 5,
                        color: dashPurple,
                        icon: Icons.group,
                        index: 3,
                      ),
                      buildDashboardItem(
                        title: 'Categories',
                        value: 12,
                        color: dashRed,
                        icon: Icons.category_outlined,
                        index: 5,
                      ),
                      buildDashboardItem(
                        title: 'Users',
                        value: 20,
                        color: dashTeal,
                        icon: Icons.group,
                        index: 7,
                      ),
                    ],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: context.screenSize ? 1 : 3,
                      child: Container(
                        color: Colors.transparent,
                        height: 400,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        height: 400,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
