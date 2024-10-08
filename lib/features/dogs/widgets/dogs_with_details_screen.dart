import 'package:flutter/material.dart';
import 'package:karo_dogs/features/dogs/widgets/dog_details_screen.dart';
import 'package:karo_dogs/features/dogs/widgets/dogs_screen.dart';

class DogsWithDetailsScreen extends StatelessWidget {
  const DogsWithDetailsScreen({
    super.key,
    this.name,
  });

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 3),
          child: const DogsScreen(),
        ),
        const VerticalDivider(),
        if (name case final label?)
          Expanded(
            flex: 2,
            child: DogDetailsScreen(label),
          ),
      ],
    );
  }
}
