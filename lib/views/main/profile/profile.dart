import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/resources/styles_manager.dart';
import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../widgets/k_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    _editProfile() {}

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left, color: dashGrey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            expandedHeight: 130,
            // floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraint) {
                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: AnimatedOpacity(
                    opacity: constraint.biggest.height <= 120 ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        user.photoURL != null
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  user.photoURL!,
                                ),
                              )
                            : const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  AssetManager.avatar,
                                ),
                              ),
                        const SizedBox(width: 10),
                        Text(
                          user.displayName ?? 'Shop Admin',
                          style: TextStyle(
                            fontSize: 12,
                            color: dashGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, dashGrey],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          user.photoURL != null
                              ? Hero(
                                  tag: user.email!,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      user.photoURL!,
                                    ),
                                  ),
                                )
                              : Hero(
                                  tag: user.email!,
                                  child: const CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage(
                                      AssetManager.avatar,
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 10),
                          Text(
                            user.displayName ?? 'Shop Admin',
                            style: getRegularStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: size.width / 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(''),
                                child: Text(
                                  'Cash outs',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: dashGrey,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  backgroundColor: dashGrey,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(30),
                                        // bottomLeft: Radius.circular(30),
                                        ),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Orders',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Vendors',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: dashGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),
                    Container(
                      height: size.height / 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView(
                        children: [
                          KListTile(
                            title: 'Email Address',
                            subtitle: user.email,
                            icon: Icons.email,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(thickness: 1),
                          ),
                          KListTile(
                            title: 'Phone Number',
                            subtitle: user.phoneNumber ?? "",
                            icon: Icons.phone,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(thickness: 1),
                          ),
                          KListTile(
                            title: 'App Settings',
                            icon: Icons.settings,
                            onTapHandler: () => null,
                            showSubtitle: false,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(thickness: 1),
                          ),
                          KListTile(
                            title: 'Edit Profile',
                            icon: Icons.edit_note,
                            onTapHandler: _editProfile,
                            showSubtitle: false,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(thickness: 1),
                          ),
                          KListTile(
                            title: 'Change Password',
                            icon: Icons.key,
                            onTapHandler: () => null,
                            showSubtitle: false,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(thickness: 1),
                          ),
                          KListTile(
                            title: 'Logout',
                            icon: Icons.logout,
                            onTapHandler: () => null,
                            showSubtitle: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
