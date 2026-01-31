import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:go_router/go_router.dart';
import '../features/features.dart';
import '../../di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),    
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
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