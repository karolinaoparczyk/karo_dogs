import 'dart:developer';

import 'package:cached_query/cached_query.dart';
import 'package:cached_storage/cached_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:karo_dogs/config.dart';
import 'package:karo_dogs/features/dogs/bloc/dogs_bloc.dart';
import 'package:karo_dogs/navigation/router.dart';
import 'package:karo_dogs/repository/dogs_api_service.dart';
import 'package:karo_dogs/repository/dogs_repository.dart';
import 'package:logging/logging.dart';

void main() async {
  _setupLogger();
  if (!kIsWeb) {
    CachedQuery.instance.config(
      storage: await CachedStorage.ensureInitialized(),
    );
  }

  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dogsRepository = useMemoized(
      () {
        final dio = Dio(BaseOptions(baseUrl: AppConfig.dogsApiUrl))
          ..interceptors.add(DogsApiInterceptor(AppConfig.dogsApiKey));
        return DogsRepository(DogsApiService.create(dio));
      },
    );
    final router = useMemoized(() => createGoRouter(context));

    return BlocProvider(
      create: (context) => DogsBloc(dogRepository: dogsRepository),
      child: SafeArea(
        child: MaterialApp.router(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}

void _setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}
