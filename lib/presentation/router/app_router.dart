import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/presentation/screen/home_screen.dart';
import 'package:flutter_bloc_example/presentation/screen/second_screen.dart';
import 'package:flutter_bloc_example/presentation/screen/third_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MyHomeScreen(
                  title: 'Home Screen',
                ));
      case '/second':
        return MaterialPageRoute(
            builder: (_) => const SecondScreen(
                  title: 'Second Screen',
                ));
      case '/third':
        return MaterialPageRoute(
            builder: (_) => const ThirdScreen(
                  title: 'Third Screen',
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const MyHomeScreen(
                  title: 'Home Screen',
                ));
    }
  }
}
