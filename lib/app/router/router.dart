import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:go_router/go_router.dart';
import '../features/home/home.dart';
import '../../di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
// для следующей лабораторной работы
// GoRoute(
//   path: '/content/:id',
//   pageBuilder: (_, state) => MaterialPage(
//     key: state.pageKey,

//     child: ContentScreen(contentId: state.pathParameters['id']!),
//   ),
// ),
  ],
);