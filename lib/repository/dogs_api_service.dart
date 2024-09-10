import 'package:dio/dio.dart';
import 'package:karo_dogs/features/dogs/models/dog.dart';
import 'package:retrofit/retrofit.dart';

part 'dogs_api_service.g.dart';

@RestApi()
abstract class DogsApiService {
  static DogsApiService create(Dio dio) => _DogsApiService(dio);

  @GET('/dogs')
  Future<List<Dog>> getDogs({
    @Query('offset') required int offset,
    @Query('min_height') int? minHeight = 1,
  });
}
