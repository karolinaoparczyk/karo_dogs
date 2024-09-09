import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_screen.dart';

GoRouter createGoRouter(BuildContext context) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DogsScreen(),
      ),
    ],
  );
}
