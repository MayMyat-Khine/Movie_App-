import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';

import '../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieModel {
  @override
  Future<List<ActorVO>?> getActors(int page) {
    return Future.value(getMockActors());
  }

  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
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
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(getMockGenres());
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return Future.value(getMockMoviesForTest());
  }

  @override
  void getNowPlayingMovies(int page) {
    // TODO: implement getNowPlayingMovies
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  void getPopularMovies(int page) {
    // TODO: implement getPopularMovies
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isPopular ?? false)
        .toList());
  }

  @override
  void getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }
}
