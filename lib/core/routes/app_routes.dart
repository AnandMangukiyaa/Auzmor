import 'dart:io';

import 'package:auzmor_assignment/models/models.dart';
import 'package:auzmor_assignment/views/pages/pages.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String detail = '/detail';
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case Routes.detail:
        return MaterialPageRoute(builder: (_) => TrainingDetailPage(training: args as Training));
      default:
        return null;
    }
  }
}
