import 'package:json_annotation/json_annotation.dart';

part 'dog.g.dart';

@JsonSerializable()
class Dog {
  Dog({
    required this.name,
    required this.imageLink,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);

  final String name;
  @JsonKey(name: 'image_link')
  final String imageLink;

  Map<String, dynamic> toJson() => _$DogToJson(this);
}
