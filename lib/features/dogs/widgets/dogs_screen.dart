import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:karo_dogs/config.dart';
import 'package:karo_dogs/features/dogs/bloc/dogs_bloc.dart';

class DogsScreen extends HookWidget {
  const DogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dogsBloc = context.watch<DogsBloc>();

    useEffect(
      () {
        dogsBloc.add(const LoadInitialDogs());
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(Icons.pets, color: Colors.white),
              ),
              TextSpan(text: ' ${AppConfig.appTitle}'),
            ],
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: switch (dogsBloc.state) {
        DogsLoading() => const LoadingIndicator(),
        DogsLoaded(:final dogs) => CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final dog = dogs.elementAt(index);
                    final photoRatio = dog.width / dog.height;
                    final deviceRatio = MediaQuery.of(context).devicePixelRatio;
                    final width = min(
                      MediaQuery.of(context).size.width,
                      dog.width,
                    );
                    final height = width / photoRatio;

                    return Container(
                      height: height,
                      width: width.toDouble(),
                      padding: const EdgeInsets.all(16),
                      child: CachedNetworkImage(
                        imageUrl: dog.url,
                        fit: BoxFit.fill,
                        memCacheHeight: (height * deviceRatio).round(),
                        memCacheWidth: (width * deviceRatio).round(),
                        placeholder: (context, url) => const LoadingIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    );
                  },
                  childCount: dogs.length,
                ),
              ),
            ],
          ),
        DogsError() => const Center(child: Text('Failed to load dogs')),
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
