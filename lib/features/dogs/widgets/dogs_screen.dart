import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:karo_dogs/config.dart';
import 'package:karo_dogs/features/dogs/bloc/dogs_bloc.dart';

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

                      final dog = dogs.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          title: Text(
                            '${index + 1}. ${dog.name}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          tileColor: Colors.green.shade100,
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
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

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
