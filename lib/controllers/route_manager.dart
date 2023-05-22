import '../views/main/main_screen.dart';
import '../views/splash/entry.dart';

class RouteManager {
  static const String entryScreen = "/entry_screen";

  static const String authScreen = "/auth";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String signupAcknowledgeScreen = "/signupAcknowledge";
  static const String mainScreen = '/customerHomeScreen';

  static const String sellerMainScreen = '/sellerMainScreen';
}

final routes = {
  RouteManager.entryScreen: (context) => const EntryScreen(),
  RouteManager.mainScreen: (context) => const MainScreen(),
};
