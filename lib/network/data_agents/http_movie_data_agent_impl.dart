// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
// import 'package:movie_app_ui/network/api_constants.dart';
// import 'package:movie_app_ui/network/movie_data_agent.dart';

// class HttpMovieDataAgentImpl extends MovieDateAgent {
//   @override
//   Future<List<MovieVO>> getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE_EN_US,
//       PARAM_PAGE: page.toString()
//     };

//     var url =
//         Uri.https(BASE_URL_HTTP, ENDPOINT_GET_NOW_PLAYING, queryParameters);

//     http.get(url).then((value) {
//       debugPrint("Now Playing Movies ========> ${value.body.toString()}");
//     }).catchError((error) {
//       debugPrint("Error =======> ${error.toString()}");
//     });
//   }
// }
