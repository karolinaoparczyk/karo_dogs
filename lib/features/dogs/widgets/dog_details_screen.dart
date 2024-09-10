import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:karo_dogs/common/dog_scaffold.dart';
import 'package:karo_dogs/common/loading_indicator.dart';
import 'package:karo_dogs/features/dogs/bloc/dogs_bloc.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:more/more.dart';

class DogDetailsScreen extends HookWidget {
  const DogDetailsScreen(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final dog = context.select<DogsBloc, Dog?>(
      (bloc) => switch (bloc.state) {
        DogsLoaded(:final dogs) =>
          dogs.firstWhereOrNull((dog) => dog.name == name),
        _ => null,
      },
    );

    if (dog == null) {
      return const SizedBox();
    }

    return DogScaffold(
      title: dog.name,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: CachedNetworkImage(
                    imageUrl: dog.imageLink,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const LoadingIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              _Content(
                label: 'Good with children',
                value: dog.goodWithChildren,
              ),
              _Content(
                label: 'Good with other dogs',
                value: dog.goodWithOtherDogs,
              ),
              _Content(
                label: 'Good with strangers',
                value: dog.goodWithStrangers,
              ),
              _Content(label: 'Shedding', value: dog.shedding),
              _Content(label: 'Grooming', value: dog.grooming),
              _Content(label: 'Drooling', value: dog.drooling),
              _Content(label: 'Coat length', value: dog.coatLength),
              _Content(label: 'Playfulness', value: dog.playfulness),
              _Content(label: 'Protectiveness', value: dog.protectiveness),
              _Content(label: 'Trainability', value: dog.trainability),
              _Content(label: 'Energy', value: dog.energy),
              _Content(label: 'Barking', value: dog.barking),
              _Content(
                label: 'Min life expectancy',
                value: dog.minLifeExpectancy,
              ),
              _Content(
                label: 'Max life expectancy',
                value: dog.maxLifeExpectancy,
              ),
            ].separatedBy(Divider.new).toList(),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.label,
    required this.value,
  });

  final String label;
  final num value;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16);

    return Row(
      children: [
        Expanded(
          child: Text(label, style: style, overflow: TextOverflow.ellipsis),
        ),
        const Spacer(),
        Text(value.toString(), style: style),
      ],
    );
  }
}
