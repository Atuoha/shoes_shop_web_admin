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
    Widget _buildDashboardItem(
      String title,
      int value,
      Color color,
      IconData icon,
      int index,
    ) {
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
                  Icon(icon, color: Colors.white),
                  Text(
                    title,
                    style: getBoldStyle(
                      fontSize: FontSize.s18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                value.toString(),
                style: getMediumStyle(
                  fontSize: FontSize.s30,
                  color: Colors.white,
                ),
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
                  'View all',
                  style: getRegularStyle(color: accentColor),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: context.screenSize ? 2 : 6,
              children: [
                _buildDashboardItem(
                    'Orders', 10, dashBlue, Icons.shopping_cart_checkout, 2),
                _buildDashboardItem(
                    'Cash Outs', 15, dashGrey, Icons.monetization_on, 6),
                _buildDashboardItem(
                    'Products', 8, dashOrange, Icons.shopping_bag, 1),
                _buildDashboardItem('Vendors', 5, dashPurple, Icons.group, 3),
                _buildDashboardItem(
                    'Categories', 12, dashRed, Icons.category_outlined, 5),
                _buildDashboardItem('Users', 20, dashTeal, Icons.group, 7),
              ],
            )
          ],
        ),
      ),
    );
  }
}
