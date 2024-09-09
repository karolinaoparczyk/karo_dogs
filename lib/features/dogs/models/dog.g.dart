// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dog _$DogFromJson(Map<String, dynamic> json) => Dog(
      id: json['id'] as String,
      url: json['url'] as String,
      width: json['width'] as num,
      height: json['height'] as num,
      breeds:
          (json['breeds'] as List<dynamic>).map((e) => e as String).toList(),
    );
