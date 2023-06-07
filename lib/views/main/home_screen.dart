import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/constants/color.dart';
import 'package:shoes_shop_admin/resources/styles_manager.dart';
import 'package:shoes_shop_admin/views/main/main_screen.dart';
import '../../models/app_data.dart';
import '../../resources/font_manager.dart';
import '../components/app_data_graph.dart';
import '../components/category_pie_data.dart';
import '../widgets/build_dashboard_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<AppData> data = [
      AppData('Vendors', 35),
      AppData('Products', 28),
      AppData('Orders', 34),
      AppData('Users', 32),
      AppData('Categories', 40)
    ];



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
                      BuildDashboardContainer(
                        title: 'Orders',
                        value: 10,
                        color: dashBlue,
                        icon: Icons.shopping_cart_checkout,
                        index: 2,
                      ),
                      BuildDashboardContainer(
                        title: 'Cash Outs',
                        value: 15,
                        color: dashGrey,
                        icon: Icons.monetization_on,
                        index: 6,
                      ),
                      BuildDashboardContainer(
                        title: 'Products',
                        value: 8,
                        color: dashOrange,
                        icon: Icons.shopping_bag,
                        index: 1,
                      ),
                      BuildDashboardContainer(
                        title: 'Vendors',
                        value: 5,
                        color: dashPurple,
                        icon: Icons.group,
                        index: 3,
                      ),
                      BuildDashboardContainer(
                        title: 'Categories',
                        value: 12,
                        color: dashRed,
                        icon: Icons.category_outlined,
                        index: 5,
                      ),
                      BuildDashboardContainer(
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
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      return Row(
                        children: [
                          Expanded(flex: 3, child: AppDataGraph(data: data)),
                          const SizedBox(width: 30),
                          const Expanded(child: CategoryDataPie()),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          AppDataGraph(data: data),
                          const SizedBox(width: 30),
                          const CategoryDataPie(),
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
