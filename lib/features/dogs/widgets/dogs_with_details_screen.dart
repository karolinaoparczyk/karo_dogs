import 'package:flutter/material.dart';
import 'package:karo_dogs/features/dogs/widgets/dog_details_screen.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_screen.dart';

class DogsWithDetailsPage extends Page<void> {
  const DogsWithDetailsPage({
    super.key,
    this.dogName,
  });

  final String? dogName;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          DogsWithDetailsScreen(dogName: dogName),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      settings: this,
    );
  }
}

class DogsWithDetailsScreen extends StatelessWidget {
  const DogsWithDetailsScreen({
    super.key,
    this.dogName,
  });

  final String? dogName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const DogsScreen(),
        ),
        const VerticalDivider(),
        if (dogName case final name?)
          Expanded(
            flex: 2,
            child: DogDetailsScreen(name),
          ),
      ],
    );
  }
}
