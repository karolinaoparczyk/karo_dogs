import 'package:cached_query/cached_query.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:karo_dogs/repository/dogs_repository.dart';
import 'package:logging/logging.dart';

class DogsBloc extends Bloc<DogsEvent, DogsState> {
  DogsBloc({required this.dogRepository}) : super(const DogsLoading()) {
    on<LoadInitialDogs>(fetchDogs);
    on<LoadMoreDogs>(loadMore);
  }

  final DogsRepository dogRepository;

  final _logger = Logger('DogsBloc');

  Future<void> fetchDogs(
    LoadInitialDogs event,
    Emitter<DogsState> emit,
  ) async {
    return emit.forEach(
      dogRepository.getDogs().stream,
      onData: (queryState) {
        final data = queryState.data?.flattened;
        if (data == null ||
            state is DogsLoading && queryState.status == QueryStatus.loading) {
          return const DogsLoading();
        }

        return DogsLoaded(
          data,
          hasMore: !queryState.hasReachedMax,
        );
      },
      onError: (err, st) {
        _logger.severe('Fetching dogs failed', err, st);
        return const DogsError();
      },
    );
  }

  Future<void> loadMore(
    LoadMoreDogs event,
    Emitter<DogsState> emit,
  ) {
    return dogRepository.getDogs().getNextPage();
  }
}

sealed class DogsState {
  const DogsState();
}

class DogsLoading extends DogsState {
  const DogsLoading();
}

class DogsLoaded extends DogsState {
  const DogsLoaded(
    this.dogs, {
    required this.hasMore,
  });

  final Iterable<Dog> dogs;
  final bool hasMore;
}

class DogsError extends DogsState {
  const DogsError();
}

sealed class DogsEvent {
  const DogsEvent();
}

class LoadInitialDogs extends DogsEvent {
  const LoadInitialDogs();
}

class LoadMoreDogs extends DogsEvent {
  const LoadMoreDogs();
}
