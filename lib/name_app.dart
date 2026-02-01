import 'app/app.dart';
import 'package:flutter/material.dart';
import 'auth_setup.dart'; // Добавляем импорт

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthSetup.wrapWithProviders(
      MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Индекс качества воздуха',
        theme: AppTheme.lightTheme,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}