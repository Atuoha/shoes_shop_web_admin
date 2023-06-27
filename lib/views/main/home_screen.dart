import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/constants/color.dart';
import '../../models/app_data.dart';
import '../../models/chart_sample.dart';
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

  var orders = 0;
  var cashOuts = 0;
  var users = 0;
  var categories = 0;
  var vendors = 0;
  var products = 0;

  // chart sample data
  List<ChartSampleData> chartSampleData = [];

  // fetch categories with product count
  Future<void> fetchCategoriesWithData() async {
    List<String> categories = [];

    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        categories.add(doc['category']);
      }
    }).whenComplete(
      () async {
        for (var category in categories) {
          int number = 0;
          await FirebaseFirestore.instance
              .collection('products')
              .where('category', isEqualTo: category)
              .get()
              .then((QuerySnapshot snapshot) {
            number = snapshot.docs.length;
          });

          setState(() {
            chartSampleData.add(
              ChartSampleData(
                x: category,
                y: number == 0 ? 0.1: number,
                text: category,
              ),
            );
          });
        }
      },
    );
  }

  Future<void> fetchData() async {
    // orders
    await FirebaseFirestore.instance.collection('orders').get().then(
          (QuerySnapshot data) => {
            setState(() {
              orders = data.docs.length;
            }),
          },
        );

    // products
    await FirebaseFirestore.instance.collection('products').get().then(
          (QuerySnapshot data) => {
            setState(() {
              products = data.docs.length;
            }),
          },
        );

    // users
    await FirebaseFirestore.instance.collection('customers').get().then(
          (QuerySnapshot data) => {
            setState(() {
              users = data.docs.length;
            }),
          },
        );

    // categories
    await FirebaseFirestore.instance.collection('categories').get().then(
          (QuerySnapshot data) => {
            setState(() {
              categories = data.docs.length;
            }),
          },
        );

    // checkouts
    await FirebaseFirestore.instance.collection('cash_outs').get().then(
          (QuerySnapshot data) => {
            setState(() {
              cashOuts = data.docs.length;
            }),
          },
        );

    // vendors
    await FirebaseFirestore.instance.collection('vendors').get().then(
          (QuerySnapshot data) => {
            setState(() {
              vendors = data.docs.length;
            }),
          },
        );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCategoriesWithData();
  }

  @override
  Widget build(BuildContext context) {
    // data
    List<AppData> data = [
      AppData(
        title: 'Orders',
        number: orders,
        color: dashBlue,
        icon: Icons.shopping_cart_checkout,
        index: 2,
      ),
      AppData(
        title: 'Cash Outs',
        number: cashOuts,
        color: dashGrey,
        icon: Icons.monetization_on,
        index: 6,
      ),
      AppData(
        title: 'Products',
        number: products,
        color: dashOrange,
        icon: Icons.shopping_bag,
        index: 1,
      ),
      AppData(
        title: 'Vendors',
        number: vendors,
        color: dashPurple,
        icon: Icons.group,
        index: 3,
      ),
      AppData(
        title: 'Categories',
        number: categories,
        color: dashRed,
        icon: Icons.category_outlined,
        index: 5,
      ),
      AppData(
        title: 'Users',
        number: users,
        color: dashTeal,
        icon: Icons.group,
        index: 7,
      ),
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

                  return GridView.builder(
                    itemCount: data.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount),
                    itemBuilder: (context, index) => BuildDashboardContainer(
                      title: data[index].title,
                      value: data[index].number,
                      color: data[index].color,
                      icon: data[index].icon,
                      index: data[index].index,
                    ),
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
                          Expanded(
                            child: chartSampleData.isNotEmpty
                                ? CategoryDataPie(
                                    chartSampleData: chartSampleData,
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          AppDataGraph(data: data),
                          const SizedBox(width: 30),
                          CategoryDataPie(chartSampleData: chartSampleData),
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
