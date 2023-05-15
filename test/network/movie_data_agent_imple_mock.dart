import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';

import '../mock_data/mock_data.dart';

class MovieDataAgentImplMock extends MovieDateAgent {
  @override
  Future<List<ActorVO>?> getActors(int page) {
    return Future.value(getMockActors());
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return Future.value(getMockCredits());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenres());
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return Future.value(getMockMoviesForTest());
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying == true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return Future.value(getMockMoviesForTest()
        .where((element) => element.isPopular == true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return Future.value(getMockMoviesForTest()
        .where((element) => element.isTopRated == true)
        .toList());
  }
}
