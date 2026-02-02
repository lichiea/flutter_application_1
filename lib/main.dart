import 'package:flutter/material.dart';
import 'name_app.dart';
import 'di/di.dart';
import 'auth_setup.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthSetup.initialize();
  setupLocator();
  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };
  runApp(AppName());
}

