import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'dog.g.dart';

@JsonSerializable()
class Dog {
  Dog({
    required this.name,
    required this.imageLink,
    required this.goodWithChildren,
    required this.goodWithOtherDogs,
    required this.shedding,
    required this.grooming,
    required this.drooling,
    required this.coatLength,
    required this.goodWithStrangers,
    required this.playfulness,
    required this.protectiveness,
    required this.trainability,
    required this.energy,
    required this.barking,
    required this.minLifeExpectancy,
    required this.maxLifeExpectancy,
  }) : id = const Uuid().v4();

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);

  final String id;
  final String name;
  @JsonKey(name: 'image_link')
  final String imageLink;
  @JsonKey(name: 'good_with_children')
  final int goodWithChildren;
  @JsonKey(name: 'good_with_other_dogs')
  final int goodWithOtherDogs;
  final int shedding;
  final int grooming;
  final int drooling;
  @JsonKey(name: 'coat_length')
  final int coatLength;
  @JsonKey(name: 'good_with_strangers')
  final int goodWithStrangers;
  final int playfulness;
  final int protectiveness;
  final int trainability;
  final int energy;
  final int barking;
  @JsonKey(name: 'min_life_expectancy')
  final int minLifeExpectancy;
  @JsonKey(name: 'max_life_expectancy')
  final int maxLifeExpectancy;

  Map<String, dynamic> toJson() => _$DogToJson(this);
}
