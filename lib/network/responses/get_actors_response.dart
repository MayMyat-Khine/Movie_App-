import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';

part "get_actors_response.g.dart";

@JsonSerializable()
class GetActorsResponse {
  @JsonKey(name: "results")
  List<ActorVO>? results;
  GetActorsResponse(this.results);

  factory GetActorsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetActorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetActorsResponseToJson(this);
}
