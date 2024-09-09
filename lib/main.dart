import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:karo_dogs/config.dart';
import 'package:karo_dogs/navigation/router.dart';
import 'package:karo_dogs/repository/dog_api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dogApiService = useMemoized(
      () => DogApiService.create(
        Dio(BaseOptions(baseUrl: AppConfig.dogApiUrl)),
      ),
    );
    final router = useMemoized(() => createGoRouter(context));

    return Provider.value(
      value: dogApiService,
      child: MaterialApp.router(
        title: AppConfig.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        routerConfig: router,
      ),
    );
  }
}
