import 'package:flutter/material.dart';
import 'products/products.dart';
import 'vendors/vendors.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';
import '../widgets/are_you_sure_dialog.dart';
import 'carousel_banners/carousel_banners.dart';
import 'cash_outs/cash_outs.dart';
import 'categories/categories.dart';
import 'orders/orders.dart';
import '../../constants/color.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _pageIndex = 0;
  bool isExtended = false;
  final List<Widget> _pages = const [
    HomeScreen(),
    ProductScreen(),
    OrdersScreen(),
    VendorsScreen(),
    CarouselBanners(),
    CategoriesScreen(),
    CashOutScreen(),
  ];

  void setNewPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  // for navigation rail
  toggleIsExtended() {
    setState(() {
      isExtended = !isExtended;
    });
  }

  // logout
  logout() {}

  // logout dialog
  logoutDialog() {
    areYouSureDialog(
      title: 'Logout',
      content: 'Are you sure you want to logout',
      context: context,
      action: logout,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetManager.logoTransparent, width: 40),
            RichText(
              text: TextSpan(
                text: 'SHOES',
                children: [
                  TextSpan(
                    text: 'SHOP',
                    style: getMediumStyle(
                      color: primaryColor,
                    ),
                    children: const [
                      TextSpan(text: ' ADMIN'),
                    ],
                  )
                ],
                style: getMediumStyle(
                  color: accentColor,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logoutDialog(),
            icon: const Icon(
              Icons.logout,
              color: accentColor,
            ),
          ),

        ],
        leading: IconButton(
          onPressed: () => setState(() {
            isExtended = !isExtended;
          }),
          icon: const Icon(
            Icons.menu,
            color: accentColor,
          ),
        ),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      selectedLabelTextStyle:
                          const TextStyle(color: primaryColor),
                      unselectedIconTheme:
                          const IconThemeData(color: greyFontColor, size: 18),
                      unselectedLabelTextStyle:
                          const TextStyle(color: greyFontColor),
                      onDestinationSelected: (index) => setState(() {
                        _pageIndex = index;
                      }),
                      labelType: NavigationRailLabelType.none,
                      leading: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: accentColor.withOpacity(0.2),
                            backgroundImage: const AssetImage(
                              AssetManager.avatar,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Leo Philip',
                            style: getMediumStyle(color: accentColor),
                          )
                        ],
                      ),
                      extended: isExtended,
                      selectedIconTheme: const IconThemeData(
                        color: primaryColor,
                      ),
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.dashboard_outlined,
                          ),
                          label: Text('Dashboard'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.shopping_bag_outlined),
                          label: Text('Products'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.shopping_cart_checkout),
                          label: Text('Orders'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.group_outlined),
                          label: Text('Vendors'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.view_carousel),
                          label: Text('Carousels'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.category_outlined),
                          label: Text('Categories'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.monetization_on_outlined),
                          label: Text('Cash outs'),
                        ),
                      ],
                      selectedIndex: _pageIndex,
                    ),
                  ),
                ),
              );
            }),
          ),
          Expanded(child: Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).padding.top,left:18,right:18,),
            child: _pages[_pageIndex],
          ))
        ],
      ),
    );
  }
}
