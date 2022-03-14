// To parse this JSON data, do
//
//     final episodeModel = episodeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EpisodeModel> episodeModelFromJson(String str) => List<EpisodeModel>.from(json.decode(str).map((x) => EpisodeModel.fromJson(x)));

String episodeModelToJson(List<EpisodeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EpisodeModel {
  EpisodeModel({
    required this.id,
    required this.url,
    required this.name,
    required this.season,
    required this.number,
    required this.airdate,
    required this.airstamp,
    required this.runtime,
    required this.rating,
    required this.image,
    required this.summary,
    required this.links,
  });

  int id;
  String url;
  String name;
  int season;
  int number;
  DateTime airdate;
  DateTime airstamp;
  int runtime;
  Rating rating;
  Image image;
  String summary;
  Links links;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    id: json["id"],
    url: json["url"],
    name: json["name"],
    season: json["season"],
    number: json["number"],
    airdate: DateTime.parse(json["airdate"]),
    airstamp: DateTime.parse(json["airstamp"]),
    runtime: json["runtime"],
    rating: Rating.fromJson(json["rating"]),
    image: Image.fromJson(json["image"]),
    summary: json["summary"],
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "name": name,
    "season": season,
    "number": number,
    "airdate": "${airdate.year.toString().padLeft(4, '0')}-${airdate.month.toString().padLeft(2, '0')}-${airdate.day.toString().padLeft(2, '0')}",
    "airstamp": airstamp.toIso8601String(),
    "runtime": runtime,
    "rating": rating.toJson(),
    "image": image.toJson(),
    "summary": summary,
    "_links": links.toJson(),
  };
}

enum Airtime { THE_2200, THE_2100 }

final airtimeValues = EnumValues({
  "21:00": Airtime.THE_2100,
  "22:00": Airtime.THE_2200
});

class Image {
  Image({
    required this.medium,
    required this.original,
  });

  String medium;
  String original;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    medium: json["medium"],
    original: json["original"],
  );

  Map<String, dynamic> toJson() => {
    "medium": medium,
    "original": original,
  };
}

class Links {
  Links({
    required this.self,
  });

  Self self;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: Self.fromJson(json["self"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self.toJson(),
  };
}

class Self {
  Self({
    required this.href,
  });

  String href;

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Rating {
  Rating({
    required this.average,
  });

  double average;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    average: json["average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "average": average,
  };
}

enum Type { REGULAR }

final typeValues = EnumValues({
  "regular": Type.REGULAR
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
