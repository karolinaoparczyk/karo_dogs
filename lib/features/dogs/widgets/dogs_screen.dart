import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:karo_dogs/common/dog_scaffold.dart';
import 'package:karo_dogs/common/loading_indicator.dart';
import 'package:karo_dogs/features/dogs/bloc/dogs_bloc.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';

class DogsScreen extends HookWidget {
  const DogsScreen({super.key});

  static bool _isBottom(ScrollController scrollController) {
    if (!scrollController.hasClients) {
      return false;
    }
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    return currentScroll >= (maxScroll - 100);
  }

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

    final scrollController = useScrollController();

    useEffect(
      () {
        void listener() {
          if (!_isBottom(scrollController)) {
            return;
          }

          if (dogsBloc.state case DogsLoaded(hasMore: true)) {
            dogsBloc.add(const LoadMoreDogs());
          }
        }

        scrollController.addListener(listener);

        return () => scrollController.removeListener(listener);
      },
      const [],
    );

    return DogScaffold(
      body: switch (dogsBloc.state) {
        DogsLoading() => const LoadingIndicator(),
        DogsLoaded(:final dogs) => CustomScrollView(
            controller: scrollController,
            slivers: [
              if (dogs.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      if (dogsBloc.state case DogsLoaded(hasMore: true)
                          when index == dogs.length) {
                        return const LoadingIndicator();
                      }

                      return _DogRow(dogs.elementAt(index), index);
                    },
                    itemCount: dogs.length + 1,
                    separatorBuilder: (_, __) => const Divider(),
                  ),
                ),
            ],
          ),
        DogsError() => const Center(child: Text('Failed to load dogs')),
      },
    );
  }
}

class _DogRow extends StatelessWidget {
  const _DogRow(this.dog, this.index);

  final Dog dog;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        title: Text(
          '${index + 1}. ${dog.name}',
          style: const TextStyle(fontSize: 20),
        ),
        tileColor: Colors.green.shade100,
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.go('/dogs/${dog.name}'),
      ),
    );
  }
}
