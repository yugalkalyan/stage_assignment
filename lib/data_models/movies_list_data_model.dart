import 'dart:convert';

import 'package:hive/hive.dart';
part 'movies_list_data_model.g.dart';

MoviesListDataModel moviesListDataModelFromJson(String str) => MoviesListDataModel.fromJson(json.decode(str));


class MoviesListDataModel {
  List<MovieListResult> results;
  int totalPages;

  MoviesListDataModel({
    required this.results,
    required this.totalPages,
  });

  factory MoviesListDataModel.fromJson(Map<String, dynamic> json) => MoviesListDataModel(
    results: json["results"]!=null?List<MovieListResult>.from(json["results"].map((x) => MovieListResult.fromJson(x))):[],
    totalPages: json["total_pages"]??0,
  );

}

@HiveType(typeId: 0)
class MovieListResult extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String originalTitle;

  @HiveField(2)
  String posterPath;

  @HiveField(3)
  String mediaType;

  @HiveField(4)
  String originalLanguage;

  MovieListResult({
    required this.id,
    required this.originalTitle,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
  });

  factory MovieListResult.fromJson(Map<String, dynamic> json) => MovieListResult(
    id: json["id"] ?? 0,
    originalTitle: json["original_title"] ?? "",
    posterPath: json["poster_path"] ?? "",
    mediaType: json["media_type"] ?? "",
    originalLanguage: json["original_language"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "original_title": originalTitle,
    "poster_path": posterPath,
    "media_type": mediaType,
    "original_language": originalLanguage,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieListResult &&
        other.id == id &&
        other.originalTitle == originalTitle &&
        other.posterPath == posterPath &&
        other.mediaType == mediaType &&
        other.originalLanguage == originalLanguage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    originalTitle.hashCode ^
    posterPath.hashCode ^
    mediaType.hashCode ^
    originalLanguage.hashCode;
  }
}

