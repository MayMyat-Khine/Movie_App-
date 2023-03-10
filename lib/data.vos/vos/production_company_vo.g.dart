// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_company_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCompaniesVO _$ProductionCompaniesVOFromJson(
        Map<String, dynamic> json) =>
    ProductionCompaniesVO(
      json['id'] as int?,
      json['logo_path'] as String?,
      json['name'] as String?,
      json['origin_country'] as String?,
    );

Map<String, dynamic> _$ProductionCompaniesVOToJson(
        ProductionCompaniesVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };
