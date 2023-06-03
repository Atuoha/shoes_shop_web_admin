import '../views/auth/auth.dart';
import '../views/main/main_screen.dart';
import '../views/splash/entry.dart';

class RouteManager {
  static const String entryScreen = "/entry_screen";

  static const String authScreen = "/auth";
  static const String forgotPasswordScreen = "/forgot";
  static const String signupAcknowledgeScreen = "/signup_acknowledge";
  static const String mainScreen = '/home';

}

final routes = {
  RouteManager.entryScreen: (context) => const EntryScreen(),
  RouteManager.mainScreen: (context) => const MainScreen(),
  RouteManager.authScreen: (context)=> const AuthenticationScreen(),
};
