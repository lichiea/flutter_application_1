import 'package:flutter/material.dart';
import 'name_app.dart';
import 'di/di.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  setupLocator();
  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };
  runApp(AppName());
}
