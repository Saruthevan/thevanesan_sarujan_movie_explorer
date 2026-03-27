// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  title: json['title'] as String?,
  overview: json['overview'] as String?,
  posterPath: json['poster_path'] as String?,
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'poster_path': instance.posterPath,
  'title': instance.title,
  'overview': instance.overview,
};
