import 'package:flutter/material.dart';
import 'name_app.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };
  runApp(AppName());
}
