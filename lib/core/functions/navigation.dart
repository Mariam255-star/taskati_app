import 'package:flutter/material.dart';

Future<T?> pushTo<T>(BuildContext context, Widget screen) {
  return Navigator.of(context).push<T>(
    MaterialPageRoute(builder: (_) => screen),
  );
}

Future<T?> pushWithReplacement<T>(BuildContext context, Widget screen) {
  return Navigator.of(context).pushReplacement<T, T>(
    MaterialPageRoute(builder: (_) => screen),
  );
}
