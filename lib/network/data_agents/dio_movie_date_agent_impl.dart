// import 'package:dio/dio.dart';
// import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
// import 'package:movie_app_ui/network/api_constants.dart';
// import 'package:movie_app_ui/network/movie_data_agent.dart';

// class DioMovieDateAgentImpl extends MovieDateAgent {
//   @override
//   Future<List<MovieVO>> getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE_EN_US,
//       PARAM_PAGE: page.toString()
//     };

//     Dio()
//         .get("$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
//             queryParameters: queryParameters)
//         .asStream()
//         .map((event) => event.data)
//         .toString();
//     //     .then((value) {
//     //   debugPrint("Now Playing Movies ========> ${value.toString()}");
//     // }).catchError((error) {
//     //   debugPrint("Error =======> ${error.toString()}");
//     // });
//   }
// }
