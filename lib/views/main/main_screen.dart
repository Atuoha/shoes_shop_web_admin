import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';
import '../widgets/animation_rail.dart';
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
  bool isExtended = false;
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

  toggleIsExtended() {
    setState(() {
      isExtended = !isExtended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetManager.logo, width: 40),
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
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NavigationRail(
              selectedLabelTextStyle: const TextStyle(color: primaryColor),
              unselectedIconTheme: const IconThemeData(color: greyFontColor),
              unselectedLabelTextStyle: const TextStyle(color: greyFontColor),
              onDestinationSelected: (index) => setState(() {
                _pageIndex = index;
              }),
              // labelType: NavigationRailLabelType.selected,
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
                size: 45,
                color: primaryColor,
              ),
              trailing: AnimatedRail(
                fnc: toggleIsExtended,
                widget: isExtended
                    ? Row(
                        children: [
                          Icon(
                            isExtended
                                ? Icons.chevron_left
                                : Icons.chevron_right,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Hide',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    : IconButton(
                        onPressed: () => setState(() {
                          isExtended = !isExtended;
                        }),
                        icon: Icon(
                          isExtended ? Icons.chevron_left : Icons.chevron_right,
                        ),
                      ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info),
                  label: Text('About'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
              selectedIndex: _pageIndex,
            ),
          ),
          Expanded(child: _pages[_pageIndex])
        ],
      ),
    );
  }
}
