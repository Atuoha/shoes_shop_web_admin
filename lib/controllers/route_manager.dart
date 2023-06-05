import 'package:shoes_shop_admin/views/main/profile/profile.dart';

import '../views/auth/auth.dart';
import '../views/main/main_screen.dart';
import '../views/splash/entry.dart';

class RouteManager {
  static const String entryScreen = "/entry_screen";

  static const String authScreen = "/auth";
  static const String forgotPasswordScreen = "/forgot";
  static const String signupAcknowledgeScreen = "/signup_acknowledge";
  static const String mainScreen = '/home';
  static const String profileScreen = '/profile';
}

final routes = {
  RouteManager.entryScreen: (context) => const EntryScreen(),
  RouteManager.mainScreen: (context) => const MainScreen(),
  RouteManager.authScreen: (context) => const AuthenticationScreen(),
  RouteManager.profileScreen: (context) => const ProfileScreen(),
};
