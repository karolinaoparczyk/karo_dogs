import 'package:cached_query/cached_query.dart';
import 'package:dio/dio.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:karo_dogs/repository/dogs_api_service.dart';
import 'package:logging/logging.dart';

class DogsRepository {
  DogsRepository(this.dogApiService);

  final DogsApiService dogApiService;

  final _logger = Logger('DogsRepository');

  InfiniteQuery<List<Dog>, int> getDogs({int offset = 10}) {
    return InfiniteQuery(
      key: ApiKeys.getDogs(offset),
      getNextArg: (state) {
        return switch (state) {
          InfiniteQueryState(lastPage: []) => null,
          InfiniteQueryState(:final length) => length + 1,
        };
      },
      queryFn: (page) => dogApiService.getDogs(offset: offset),
      config: QueryConfig(
        refetchDuration: const Duration(days: 1),
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

class DogsApiInterceptor extends Interceptor {
  const DogsApiInterceptor(this.dogsApiKey);

  final String dogsApiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = dogsApiKey;
    handler.next(options);
  }
}
