import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/api_constants.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';
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
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.result)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.result)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.result)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mApi
        .getMovieByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.result)
        .first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }
}
