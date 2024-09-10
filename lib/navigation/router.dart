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
          name: 'dogs',
          path: '/dogs/:dogName',
          builder: (context, state) {
            return DogsWithDetailsScreen(
              dogName: state.pathParameters['dogName'],
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
              path: ':dogName',
              builder: (context, state) {
                final id = state.pathParameters['dogName'];
                if (id == null) {
                  throw Exception('Dog name is required');
                }

                return DogDetailsScreen(id);
              },
            ),
        ],
      ),
    ],
  );
}
