import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  
  @JsonKey(name: 'title')
  final String? _rawTitle;

  @JsonKey(name: 'overview')
  final String? _rawOverview;

  
  @JsonKey(name: 'poster_path')
  final String? posterPath; 


  const Movie({
    String? title,
    String? overview,
    this.posterPath,
  })  : _rawTitle = title,
        _rawOverview = overview;

  String get title => _rawTitle ?? 'Titre inconnu';
  String get overview => _rawOverview ?? 'Aucune description disponible.';

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}