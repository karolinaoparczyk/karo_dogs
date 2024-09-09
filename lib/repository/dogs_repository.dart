import 'package:cached_query/cached_query.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:karo_dogs/repository/dogs_api_service.dart';
import 'package:logging/logging.dart';

class DogsRepository {
  DogsRepository(this.dogApiService);

  final DogsApiService dogApiService;

  final _logger = Logger('DogsRepository');

  InfiniteQuery<List<Dog>, int> getDogs({int limit = 1}) {
    return InfiniteQuery(
      key: ApiKeys.getDogs(limit),
      getNextArg: (state) {
        return switch (state) {
          InfiniteQueryState(lastPage: []) => null,
          InfiniteQueryState(:final length) => length + 1,
        };
      },
      queryFn: (page) => dogApiService.getDogs(limit: limit, page: page),
      config: QueryConfig(
        refetchDuration: const Duration(seconds: 30),
        cacheDuration: const Duration(days: 1),
      ),
      onError: (err) {
        _logger.severe('Fetching dogs failed', err);
      },
      onSuccess: (data) {
        _logger.info('Dogs data fetched');
      },
    );
  }
}

class ApiKeys {
  static String getDogs(int limit) => 'getDogs($limit)';
}
