import 'package:flutter/material.dart';

class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => navigatorKey.currentState!;
  BuildContext get lContext => navigatorKey.currentContext!;

  void pop<T>([T? results]) {
    return _navigator.pop(results);
  }

  Future<T?> push<T>(Widget page) {
    return _navigator.push<T>(
      MaterialPageRoute(builder: (_) => page)
    );
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return _navigator.pushReplacement<T, dynamic>(
      MaterialPageRoute(builder: (_) => page)
    );
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return _navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return _navigator.pushNamed(
      routeName,
      arguments: arguments
    );
  }
}