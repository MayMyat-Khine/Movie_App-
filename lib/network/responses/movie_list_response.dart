import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/date_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

part 'movie_list_response.g.dart';

@JsonSerializable()
class MovieListResponse {
  @JsonKey(name: "dates")
  DateVO? dates;

  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "results")
  List<MovieVO>? result;

  MovieListResponse(this.dates, this.page, this.result);
  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}
