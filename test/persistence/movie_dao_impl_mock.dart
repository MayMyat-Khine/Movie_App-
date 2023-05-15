import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:hive/hive.dart';
import 'package:movie_app_ui/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int, MovieVO> movieListFromDatabaseMock = {};

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<MovieVO> getMovieList() {
    return getMockMoviesForTest();
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMockMoviesForTest() != null && (getMockMoviesForTest().isNotEmpty)) {
      return getMockMoviesForTest()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  List<MovieVO> getPopularMovies() {
    if (getMockMoviesForTest() != null && (getMockMoviesForTest().isNotEmpty)) {
      return getMockMoviesForTest()
          .where((element) => element.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isPopular ?? false)
        .toList());
  }

  @override
  MovieVO? getSingleMovie(int movieId) {
    return movieListFromDatabaseMock.values
        .toList()
        .firstWhere((element) => element.id == movieId);
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if (getMockMoviesForTest() != null && (getMockMoviesForTest().isNotEmpty)) {
      return getMockMoviesForTest()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  @override
  void saveMovieList(List<MovieVO> movieList) {
    movieList.forEach((movie) {
      movieListFromDatabaseMock[movie.id ?? 0] = movie;
    });
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    if (movie != null) {
      movieListFromDatabaseMock[movie.id ?? 0] = movie;
    }
  }
}
