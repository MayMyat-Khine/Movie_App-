import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/date_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

part 'get_now_playing_response.g.dart';

@JsonSerializable()
class GetNowPlayingResponse {
  @JsonKey(name: "dates")
  DateVO? dates;

  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "result")
  List<MovieVO>? result;

  GetNowPlayingResponse(this.dates, this.page, this.result);
  factory GetNowPlayingResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNowPlayingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetNowPlayingResponseToJson(this);
}
