// To parse this JSON data, do
//
//     final showModel = showModelFromJson(jsonString);

import 'package:azlistview/azlistview.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<ShowModel> showModelFromJson(String str) => List<ShowModel>.from(json.decode(str).map((x) => ShowModel.fromJson(x)));

String showModelToJson(List<ShowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowModel extends ISuspensionBean{
  ShowModel({
    required this.id,
    required this.url,
    required this.name,
    this.type,
    this.language,
    required this.genres,
    this.status,
    required this.averageRuntime,
    required this.premiered,
    this.ended,
    required this.schedule,
    required this.rating,
    required this.weight,
    required this.externals,
    required this.image,
    required this.summary,
    required this.updated,
    required this.links,
  });

  int id;
  String url;
  String name;
  Type? type;
  Language? language;
  List<Genre> genres;
  Status? status;
  int averageRuntime;
  DateTime premiered;
  DateTime? ended;
  Schedule schedule;
  Rating rating;
  int weight;
  Network? network;
  Network? webChannel;
  Country? dvdCountry;
  Externals externals;
  Image image;
  String summary;
  int updated;
  Links links;

  factory ShowModel.fromJson(Map<String, dynamic> json) => ShowModel(
    id: json["id"],
    url: json["url"],
    name: json["name"],
    type: typeValues.map[json["type"]],
    language: languageValues.map[json["language"]],
    genres: List<Genre>.from(json["genres"].map((x) => genreValues.map[x])),
    status: statusValues.map[json["status"]],
    averageRuntime: json["averageRuntime"],
    premiered: DateTime.parse(json["premiered"]),
    ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
    schedule: Schedule.fromJson(json["schedule"]),
    rating: Rating.fromJson(json["rating"]),
    weight: json["weight"],
    externals: Externals.fromJson(json["externals"]),
    image: Image.fromJson(json["image"]),
    summary: json["summary"],
    updated: json["updated"],
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "name": name,
    "type": typeValues.reverse![type],
    "language": languageValues.reverse![language],
    "genres": List<dynamic>.from(genres.map((x) => genreValues.reverse![x])),
    "status": statusValues.reverse![status],
    "averageRuntime": averageRuntime,
    "premiered": "${premiered.year.toString().padLeft(4, '0')}-${premiered.month.toString().padLeft(2, '0')}-${premiered.day.toString().padLeft(2, '0')}",
    "ended": ended == null ? null : "${ended!.year.toString().padLeft(4, '0')}-${ended!.month.toString().padLeft(2, '0')}-${ended!.day.toString().padLeft(2, '0')}",
    "schedule": schedule.toJson(),
    "rating": rating.toJson(),
    "weight": weight,
    "network": network == null ? null : network!.toJson(),
    "webChannel": webChannel == null ? null : webChannel!.toJson(),
    "dvdCountry": dvdCountry == null ? null : dvdCountry!.toJson(),
    "externals": externals.toJson(),
    "image": image.toJson(),
    "summary": summary,
    "updated": updated,
    "_links": links.toJson(),
  };

  @override
  String getSuspensionTag() => name[0];
}

class Country {
  Country({
    this.name,
    this.code,
    this.timezone,
  });

  Name? name;
  Code? code;
  Timezone? timezone;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: nameValues.map[json["name"]],
    code: codeValues.map[json["code"]],
    timezone: timezoneValues.map[json["timezone"]],
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse![name],
    "code": codeValues.reverse![code],
    "timezone": timezoneValues.reverse![timezone],
  };
}

enum Code { US, CA, JP, GB, FR, DE }

final codeValues = EnumValues({
  "CA": Code.CA,
  "DE": Code.DE,
  "FR": Code.FR,
  "GB": Code.GB,
  "JP": Code.JP,
  "US": Code.US
});

enum Name { UNITED_STATES, CANADA, JAPAN, UNITED_KINGDOM, FRANCE, GERMANY }

final nameValues = EnumValues({
  "Canada": Name.CANADA,
  "France": Name.FRANCE,
  "Germany": Name.GERMANY,
  "Japan": Name.JAPAN,
  "United Kingdom": Name.UNITED_KINGDOM,
  "United States": Name.UNITED_STATES
});

enum Timezone { AMERICA_NEW_YORK, AMERICA_HALIFAX, ASIA_TOKYO, EUROPE_LONDON, EUROPE_PARIS, EUROPE_BUSINGEN }

final timezoneValues = EnumValues({
  "America/Halifax": Timezone.AMERICA_HALIFAX,
  "America/New_York": Timezone.AMERICA_NEW_YORK,
  "Asia/Tokyo": Timezone.ASIA_TOKYO,
  "Europe/Busingen": Timezone.EUROPE_BUSINGEN,
  "Europe/London": Timezone.EUROPE_LONDON,
  "Europe/Paris": Timezone.EUROPE_PARIS
});

class Externals {
  Externals({
    this.tvrage,
    this.thetvdb,
    this.imdb,
  });

  int? tvrage;
  int? thetvdb;
  String? imdb;

  factory Externals.fromJson(Map<String, dynamic> json) => Externals(
    tvrage: json["tvrage"],
    thetvdb: json["thetvdb"] == null ? null : json["thetvdb"],
    imdb: json["imdb"] == null ? null : json["imdb"],
  );

  Map<String, dynamic> toJson() => {
    "tvrage": tvrage,
    "thetvdb": thetvdb == null ? null : thetvdb,
    "imdb": imdb == null ? null : imdb,
  };
}

enum Genre { DRAMA, SCIENCE_FICTION, THRILLER, ACTION, CRIME, HORROR, ROMANCE, ADVENTURE, ESPIONAGE, MUSIC, MYSTERY, SUPERNATURAL, FANTASY, FAMILY, ANIME, COMEDY, HISTORY, MEDICAL, LEGAL, WESTERN, WAR, SPORTS }

final genreValues = EnumValues({
  "Action": Genre.ACTION,
  "Adventure": Genre.ADVENTURE,
  "Anime": Genre.ANIME,
  "Comedy": Genre.COMEDY,
  "Crime": Genre.CRIME,
  "Drama": Genre.DRAMA,
  "Espionage": Genre.ESPIONAGE,
  "Family": Genre.FAMILY,
  "Fantasy": Genre.FANTASY,
  "History": Genre.HISTORY,
  "Horror": Genre.HORROR,
  "Legal": Genre.LEGAL,
  "Medical": Genre.MEDICAL,
  "Music": Genre.MUSIC,
  "Mystery": Genre.MYSTERY,
  "Romance": Genre.ROMANCE,
  "Science-Fiction": Genre.SCIENCE_FICTION,
  "Sports": Genre.SPORTS,
  "Supernatural": Genre.SUPERNATURAL,
  "Thriller": Genre.THRILLER,
  "War": Genre.WAR,
  "Western": Genre.WESTERN
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

enum Language { ENGLISH, JAPANESE }

final languageValues = EnumValues({
  "English": Language.ENGLISH,
  "Japanese": Language.JAPANESE
});

class Links {
  Links({
    required this.self,
    required this.previousepisode,
    this.nextepisode,
  });

  Previousepisode self;
  Previousepisode previousepisode;
  Previousepisode? nextepisode;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: Previousepisode.fromJson(json["self"]),
    previousepisode: Previousepisode.fromJson(json["previousepisode"]),
    nextepisode: json["nextepisode"] == null ? null : Previousepisode.fromJson(json["nextepisode"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self.toJson(),
    "previousepisode": previousepisode.toJson(),
    "nextepisode": nextepisode == null ? null : nextepisode!.toJson(),
  };
}

class Previousepisode {
  Previousepisode({
    required this.href,
  });

  String href;

  factory Previousepisode.fromJson(Map<String, dynamic> json) => Previousepisode(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Network {
  Network({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  int id;
  String name;
  Country? country;
  String officialSite;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    name: json["name"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    officialSite: json["officialSite"] == null ? null : json["officialSite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country == null ? null : country!.toJson(),
    "officialSite": officialSite == null ? null : officialSite,
  };
}

class Rating {
  Rating({
    this.average,
  });

  double? average;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    average: json["average"] == null ? null : json["average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "average": average == null ? null : average,
  };
}

class Schedule {
  Schedule({
    this.time,
    required this.days,
  });

  Time? time;
  List<Day> days;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    time: timeValues.map[json["time"]],
    days: List<Day>.from(json["days"].map((x) => dayValues.map[x])),
  );

  Map<String, dynamic> toJson() => {
    "time": timeValues.reverse![time],
    "days": List<dynamic>.from(days.map((x) => dayValues.reverse![x])),
  };
}

enum Day { THURSDAY, TUESDAY, FRIDAY, SUNDAY, WEDNESDAY, SATURDAY, MONDAY }

final dayValues = EnumValues({
  "Friday": Day.FRIDAY,
  "Monday": Day.MONDAY,
  "Saturday": Day.SATURDAY,
  "Sunday": Day.SUNDAY,
  "Thursday": Day.THURSDAY,
  "Tuesday": Day.TUESDAY,
  "Wednesday": Day.WEDNESDAY
});

enum Time { THE_2200, THE_2100, THE_2000, EMPTY, THE_1200, THE_2130, THE_1300, THE_2030, THE_0900, THE_2230, THE_2300, THE_2330 }

final timeValues = EnumValues({
  "": Time.EMPTY,
  "09:00": Time.THE_0900,
  "12:00": Time.THE_1200,
  "13:00": Time.THE_1300,
  "20:00": Time.THE_2000,
  "20:30": Time.THE_2030,
  "21:00": Time.THE_2100,
  "21:30": Time.THE_2130,
  "22:00": Time.THE_2200,
  "22:30": Time.THE_2230,
  "23:00": Time.THE_2300,
  "23:30": Time.THE_2330
});

enum Status { ENDED, RUNNING, TO_BE_DETERMINED }

final statusValues = EnumValues({
  "Ended": Status.ENDED,
  "Running": Status.RUNNING,
  "To Be Determined": Status.TO_BE_DETERMINED
});

enum Type { SCRIPTED, REALITY, ANIMATION, TALK_SHOW, DOCUMENTARY }

final typeValues = EnumValues({
  "Animation": Type.ANIMATION,
  "Documentary": Type.DOCUMENTARY,
  "Reality": Type.REALITY,
  "Scripted": Type.SCRIPTED,
  "Talk Show": Type.TALK_SHOW
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
