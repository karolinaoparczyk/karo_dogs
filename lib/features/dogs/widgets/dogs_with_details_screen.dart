import 'package:flutter/material.dart';
import 'package:karo_dogs/features/dogs/widgets/dog_details_screen.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_screen.dart';

class DogsWithDetailsScreen extends StatelessWidget {
  const DogsWithDetailsScreen({
    super.key,
    this.dogId,
  });

  final String? dogId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const DogsScreen(),
        ),
        const VerticalDivider(),
        if (dogId case final id?)
          Expanded(
            flex: 2,
            child: DogDetailsScreen(id),
          ),
      ],
    );
  }
}
