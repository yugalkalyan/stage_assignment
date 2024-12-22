
import 'dart:convert';

MovieDetailDataModel movieDetailDataModelFromJson(String str) => MovieDetailDataModel.fromJson(json.decode(str));


class MovieDetailDataModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String tagline;
  String title;
  double voteAverage;

  MovieDetailDataModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.tagline,
    required this.title,
    required this.voteAverage,
  });

  factory MovieDetailDataModel.fromJson(Map<String, dynamic> json) => MovieDetailDataModel(
    backdropPath: json["backdrop_path"]??"",
    id: json["id"]??0,
    originalLanguage: json["original_language"]??"",
    originalTitle: json["original_title"]??'',
    overview: json["overview"]??"",
    popularity: json["popularity"]!=null?json["popularity"]?.toDouble():0.0,
    posterPath: json["poster_path"]??"",
    tagline: json["tagline"]??"",
    title: json["title"]??"",
    voteAverage: json["vote_average"]!=null?json["vote_average"]?.toDouble():0.0,
  );
}
