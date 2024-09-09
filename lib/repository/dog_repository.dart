import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:karo_dogs/repository/dog_api_service.dart';

class DogRepository {
  const DogRepository(this.dogApiService);

  final DogApiService dogApiService;

  Query<List<Dog>> getDogs({
    int limit = 1,
    int page = 0,
  }) {
    return Query(
      key: ApiKeys.getDogs(limit, page),
      queryFn: () => dogApiService.getDogs(limit: limit, page: page),
      config: QueryConfigFlutter(
        refetchDuration: const Duration(seconds: 30),
        cacheDuration: const Duration(days: 1),
      ),
    );
  }
}

class ApiKeys {
  static String getDogs(int limit, int page) => 'getDogs($limit, $page)';
}
