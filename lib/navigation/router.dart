import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:karo_dogs/features/dogs/widgets/dog_details_screen.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_screen.dart';

GoRouter createGoRouter(BuildContext context) {
  return GoRouter(
    initialLocation: '/dogs',
    routes: [
      GoRoute(
        path: '/dogs',
        builder: (context, state) => const DogsScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              if (id == null) {
                throw Exception('Dog ID is required');
              }

              return DogDetailsScreen(id);
            },
          ),
        ],
      ),
    ],
  );
}
