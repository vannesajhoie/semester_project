import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  static const home = '/';
  static const login = '/login';

  static Route<dynamic> generate(RouteSettings s) {
    final Widget page = s.name == login ? const LoginScreen() : const HomeScreen();
    return MaterialPageRoute(builder: (_) => page, settings: s);
  }
}