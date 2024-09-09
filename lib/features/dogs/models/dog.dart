import 'package:json_annotation/json_annotation.dart';

part 'dog.g.dart';

@JsonSerializable()
class Dog {
  Dog({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);

  final String id;
  final String url;
  final num width;
  final num height;
  final List<String>? breeds;

  Map<String, dynamic> toJson() => _$DogToJson(this);
}
