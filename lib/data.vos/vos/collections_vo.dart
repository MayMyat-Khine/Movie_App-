import 'package:json_annotation/json_annotation.dart';

part 'collections_vo.g.dart';

@JsonSerializable()
class CollectionsVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "poster_path")
  String? posterPath;

  @JsonKey(name: "backdrop_path")
  String? backdropPath;

  CollectionsVO(this.id, this.name, this.posterPath, this.backdropPath);

  factory CollectionsVO.fromJson(Map<String, dynamic> json) =>
      _$CollectionsVOFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionsVOToJson(this);
}
