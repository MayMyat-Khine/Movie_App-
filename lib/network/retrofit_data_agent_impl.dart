import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/api_constants.dart';
import 'package:movie_app_ui/network/movie_data_agent.dart';
import 'package:movie_app_ui/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDateAgent {
  late TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    var v = mApi.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString());
    // print(v);
    List<MovieVO>? list = [];
    var b = mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.result)
        .first;
    b.then((value) {
      debugPrint("aaaaaaa");
      debugPrint(value![0].originalLanguage);
      debugPrint("bbbbbb");
    });
    // return list;
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.result)
        .first;
    //     .then((response) {
    //   response.result?.forEach(
    //       (movie) => debugPrint("Moive Data========> ${movie.toString()}"));
    // }).catchError((error) {
    //   debugPrint("Error =======> ${error.toString()}");
    // });
  }
}
