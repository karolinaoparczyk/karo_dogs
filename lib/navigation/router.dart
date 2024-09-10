import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:karo_dogs/features/dogs/widgets/dog_details_screen.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_screen.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_with_details_screen.dart';

GoRouter createGoRouter(BuildContext context) {
  return GoRouter(
    initialLocation: '/dogs',
    routes: [
      if (kIsWeb)
        GoRoute(
          path: '/dogs/:name',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: DogsWithDetailsScreen(
                name: state.pathParameters['name'],
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) => child,
            );
          },
        ),
      GoRoute(
        path: '/dogs',
        builder: (context, state) =>
            kIsWeb ? const DogsWithDetailsScreen() : const DogsScreen(),
        routes: [
          if (!kIsWeb)
            GoRoute(
              path: ':name',
              builder: (context, state) {
                final name = state.pathParameters['name'];
                if (name == null) {
                  throw Exception('Dog name is required');
                }

                return DogDetailsScreen(name);
              },
            ),
        ],
      ),
    ],
  );
}
