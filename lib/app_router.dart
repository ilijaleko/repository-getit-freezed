import 'package:flutter/material.dart';
import 'constants/routes/routes.dart';
import 'screens/posts/posts_screen.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final routerConfig = GoRouter(
    initialLocation: Routes.posts,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: Container(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    _rootNavigatorKey.currentState!.pushNamed(Routes.posts);
                  },
                  child: const Text('Posts'),
                ),
              ),
              body: child);
        },
        routes: [
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: Routes.posts,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: PostsScreen())),
        ],
      ),
    ],
  );
}
