// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) =>
    HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  String? id;
  int? websiteRef;
  String? title;
  String? type;
  String? text;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<MediaElement>? media;

  HomeDataModel({
    this.id,
    this.websiteRef,
    this.title,
    this.type,
    this.text,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.media,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        id: json["_id"],
        websiteRef: json["website_ref"],
        title: json["title"],
        type: json["type"],
        text: json["text"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        media: json["media"] == null
            ? []
            : List<MediaElement>.from(
                json["media"]!.map((x) => MediaElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "website_ref": websiteRef,
        "title": title,
        "type": type,
        "text": text,
        "published_at": publishedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class MediaElement {
  String? id;
  MediaMedia? media;
  Meta? meta;
  int? group;
  int? order;
  String? type;
  String? discover;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MediaElement({
    this.id,
    this.media,
    this.meta,
    this.group,
    this.order,
    this.type,
    this.discover,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MediaElement.fromJson(Map<String, dynamic> json) => MediaElement(
        id: json["_id"],
        media:
            json["media"] == null ? null : MediaMedia.fromJson(json["media"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        group: json["group"],
        order: json["order"],
        type: json["type"],
        discover: json["discover"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "media": media?.toJson(),
        "meta": meta?.toJson(),
        "group": group,
        "order": order,
        "type": type,
        "discover": discover,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class MediaMedia {
  String? large;
  String? medium;
  String? small;
  String? original;

  MediaMedia({
    this.large,
    this.medium,
    this.small,
    this.original,
  });

  factory MediaMedia.fromJson(Map<String, dynamic> json) => MediaMedia(
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "large": large,
        "medium": medium,
        "small": small,
        "original": original,
      };
}

class Meta {
  double? aspectRatio;
  String? credits;

  Meta({
    this.aspectRatio,
    this.credits,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        aspectRatio: json["aspect_ratio"]?.toDouble(),
        credits: json["credits"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "credits": credits,
      };
}
