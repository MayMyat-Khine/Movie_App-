import 'package:json_annotation/json_annotation.dart';

part "spoken_languages_vo.g.dart";

@JsonSerializable()
class SpokenLanguagesVO {
  @JsonKey(name: "english_name")
  String? englishName;

  @JsonKey(name: "iso_639_1")
  String? iso;

  @JsonKey(name: "name")
  String? name;

  SpokenLanguagesVO(this.englishName, this.iso, this.name);

  factory SpokenLanguagesVO.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesVOFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesVOToJson(this);
}
