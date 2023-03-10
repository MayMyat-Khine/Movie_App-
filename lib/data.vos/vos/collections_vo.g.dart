// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionsVO _$CollectionsVOFromJson(Map<String, dynamic> json) =>
    CollectionsVO(
      json['id'] as int?,
      json['name'] as String?,
      json['poster_path'] as String?,
      json['backdrop_path'] as String?,
    );

Map<String, dynamic> _$CollectionsVOToJson(CollectionsVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
    };
