import 'package:flutter/material.dart';

class NavigationService {
  static Future<dynamic>? navigateTo(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<dynamic>? replaceWith(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic>? navigateAndRemoveUntil(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void goBack(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

  static Future<T?> pushWidget<T>(BuildContext context, Widget widget) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => widget),
    );
  }
}
