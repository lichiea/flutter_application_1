import 'dart:async';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:go_router/go_router.dart';
import '../features/features.dart';
import '../../di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AuthNotifier extends ChangeNotifier {
  final AuthBloc authBloc;
  StreamSubscription? _subscription;

  AuthNotifier(this.authBloc) {
    _subscription = authBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  bool get isAuthenticated {
    return authBloc.state is AuthAuthenticated;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

// Создаем глобальный экземпляр AuthNotifier (он будет инициализирован позже)
late AuthNotifier authNotifier;

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigationKey,
  refreshListenable: authNotifier, // Используем глобальный AuthNotifier
  redirect: (context, state) {
    final isAuthenticated = authNotifier.isAuthenticated;
    final currentPath = state.uri.path;
    final isLoginPage = currentPath == '/login';
    final isSignupPage = currentPath == '/signup';
    //final isHomePage = currentPath == '/home' || currentPath == '/';

    // Если пользователь не аутентифицирован и пытается получить доступ к защищенной странице
    if (!isAuthenticated && !isLoginPage && !isSignupPage) {
      return '/login';
    }

    // Если пользователь аутентифицирован и пытается перейти на страницу логина/регистрации
    if (isAuthenticated && (isLoginPage || isSignupPage)) {
      return '/home';
    }

    return null;
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        if (authNotifier.isAuthenticated) {
          return MaterialPage(
            key: state.pageKey,
            child: const HomeScreen(),
          );
        } else {
          return MaterialPage(
            key: state.pageKey,
            child: const LoginScreen(),
          );
        }
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const SignupScreen(),
      ),
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const FavoritesScreen(),
      ),
    ),
    GoRoute(
      path: '/content/:index',
      pageBuilder: (context, state) {
        final index = state.pathParameters['index'] ?? '0';
        return MaterialPage(
          key: ValueKey('content-$index'),
          child: CardScreen(contentId: index),
        );
      },
    ),
  ],
);

// Функция для инициализации router после настройки AuthNotifier
void initializeRouter(AuthBloc authBloc) {
  authNotifier = AuthNotifier(authBloc);
}