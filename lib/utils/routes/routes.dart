import 'package:counter_demo_bloc/feature/auth/presentation/page/login_page.dart';
import 'package:counter_demo_bloc/feature/counter/presentation/page/counter_page.dart';
import 'package:counter_demo_bloc/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.counter:
        return MaterialPageRoute(builder: (_) => const CounterPage());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text("No route is configured")),
              ),
        );
    }
  }
}
