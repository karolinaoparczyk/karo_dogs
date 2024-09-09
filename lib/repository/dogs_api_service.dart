import 'package:dio/dio.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:retrofit/retrofit.dart';

part 'dogs_api_service.g.dart';

@RestApi()
abstract class DogsApiService {
  static DogsApiService create(Dio dio) => _DogsApiService(dio);

  @GET('/images/search')
  Future<List<Dog>> getDogs({
    @Query('limit') int limit = 1,
    @Query('page') int page = 0,
    @Query('has_breeds') bool hasBreeds = true,
  });
}
