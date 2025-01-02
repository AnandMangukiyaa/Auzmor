part of 'models.dart';

// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);



List<Categories> categoryFromJson(dynamic str) => List<Categories>.from(str.map((x) => Categories.fromJson(x)));

String categoryToJson(List<Categories> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  int? id;
  String? name;
  String? coverImageUrl;
  List<Training> trainings;

  Categories({
    this.id,
    this.name,
    this.coverImageUrl,
    this.trainings = const [],
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    name: json["name"],
    coverImageUrl: json["cover_image_url"],
    trainings: List<Training>.from(json["trainings"].map((x) => Training.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover_image_url": coverImageUrl,
    "trainings": List<dynamic>.from(trainings.map((x) => x.toJson())),
  };
}

class Training {
  String? name;
  String? location;
  String? description;
  String? imageUrl;
  String? trainerName;

  Training({
    this.name,
    this.location,
    this.description,
    this.imageUrl,
    this.trainerName,
  });

  factory Training.fromJson(Map<String, dynamic> json) => Training(
    name: json["name"],
    location: json["location"],
    description: json["description"],
    imageUrl: json["image_url"],
    trainerName: json["trainer_name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "location": location,
    "description": description,
    "image_url": imageUrl,
    "trainer_name": trainerName,
  };
}
