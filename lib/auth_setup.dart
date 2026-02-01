import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/services/auth/auth_service.dart';
import 'app/features/auth/bloc/auth_bloc.dart';
import 'app/router/router.dart' show initializeRouter;

class AuthSetup {
  static late AuthBloc authBloc;
  static bool initialized = false;

  static void initialize() {
    if (!initialized) {
      authBloc = AuthBloc(authService: AuthService());
      initializeRouter(authBloc); // Инициализируем router
      initialized = true;
    }
  }

  static Widget wrapWithProviders(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
      ],
      child: child,
    );
  }

  static void dispose() {
    authBloc.close();
    initialized = false;
  }
}