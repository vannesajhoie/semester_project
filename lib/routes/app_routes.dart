
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/report_form_screen.dart';

class AppRoutes {
  static const home = '/';
  static const login = '/login';
  static const report = '/report';

  static Route<dynamic> generate(RouteSettings s) {
    final Widget page;

    if (s.name == login) {
      page = const LoginScreen();
    } else if (s.name == report) {
      page = ReportFormScreen();
    } else {
      page = const HomeScreen();
    }

    return MaterialPageRoute(
      builder: (_) => page,
      settings: s,
    );
  }
}
