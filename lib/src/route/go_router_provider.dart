import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hiradvantista/src/features/about/presentation/ui/about_screen.dart';
import 'package:hiradvantista/src/features/hymn/presentation/ui/favorite_hymn_list_screen.dart';
import 'package:hiradvantista/src/features/hymn/presentation/ui/hymn_list_screen.dart';
import 'package:hiradvantista/src/features/hymn/presentation/ui/hymn_screen.dart';

import '../features/dashboard/presentation/ui/dashboard_screen.dart';
import '../features/error/presentation/ui/error_screen.dart';
import 'named_route.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final Provider goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) =>
            DashboardScreen(key: state.pageKey, child: child),
        routes: [
          GoRoute(
              path: '/',
              name: NamedRoute.home,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: HymnListScreen(key: state.pageKey),
                );
              }),
          GoRoute(
              path: '/favorites',
              name: NamedRoute.favorite,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: FavoriteHymnListScreen(key: state.pageKey),
                );
              }),
          GoRoute(
              path: '/about',
              name: NamedRoute.about,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: AboutScreen(key: state.pageKey),
                );
              }),
        ],
      ),
      GoRoute(
        path: '/hymn/:id',
        name: NamedRoute.hymn,
        parentNavigatorKey: _rootNavigator,
        builder: (context, state) {
          return HymnScreen(id: int.parse(state.params['id']!), key: state.pageKey);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        RouteErrorScreen(errorMessage: state.error.toString()),
  );
});
