import 'package:flutter/material.dart';

import '../screens/details_page.dart';
import '../screens/home_page.dart';

class RouteManager {
  static const String homePage = '/';
  static const String detailsPage = '/detailsPage';

  RouteManager._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case detailsPage:
        return MaterialPageRoute(
          builder: (context) => const DetailsScreen(),
        );
      default:
        throw const FormatException('Page not found! Check routes');
    }
  }
}
