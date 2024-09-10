// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dog _$DogFromJson(Map<String, dynamic> json) => Dog(
      name: json['name'] as String,
      imageLink: json['image_link'] as String,
      goodWithChildren: (json['good_with_children'] as num).toInt(),
      goodWithOtherDogs: (json['good_with_other_dogs'] as num).toInt(),
      shedding: (json['shedding'] as num).toInt(),
      grooming: (json['grooming'] as num).toInt(),
      drooling: (json['drooling'] as num).toInt(),
      coatLength: (json['coat_length'] as num).toInt(),
      goodWithStrangers: (json['good_with_strangers'] as num).toInt(),
      playfulness: (json['playfulness'] as num).toInt(),
      protectiveness: (json['protectiveness'] as num).toInt(),
      trainability: (json['trainability'] as num).toInt(),
      energy: (json['energy'] as num).toInt(),
      barking: (json['barking'] as num).toInt(),
      minLifeExpectancy: (json['min_life_expectancy'] as num).toInt(),
      maxLifeExpectancy: (json['max_life_expectancy'] as num).toInt(),
    );

Map<String, dynamic> _$DogToJson(Dog instance) => <String, dynamic>{
      'name': instance.name,
      'image_link': instance.imageLink,
      'good_with_children': instance.goodWithChildren,
      'good_with_other_dogs': instance.goodWithOtherDogs,
      'shedding': instance.shedding,
      'grooming': instance.grooming,
      'drooling': instance.drooling,
      'coat_length': instance.coatLength,
      'good_with_strangers': instance.goodWithStrangers,
      'playfulness': instance.playfulness,
      'protectiveness': instance.protectiveness,
      'trainability': instance.trainability,
      'energy': instance.energy,
      'barking': instance.barking,
      'min_life_expectancy': instance.minLifeExpectancy,
      'max_life_expectancy': instance.maxLifeExpectancy,
    };
