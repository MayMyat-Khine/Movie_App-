import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  void saveMovieList(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getMovieList() {
    return getMovieBox().values.toList();
  }

  MovieVO? getSingleMovie(int movieId) {
    return getMovieBox().get(movieId);
  }

  /// Reactive
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getMovieList()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(
        getMovieList().where((element) => element.isPopular ?? false).toList());
  }

  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getMovieList()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  List<MovieVO> getNowPlayingMovies() {
    if (getMovieList() != null && (getMovieList().isNotEmpty)) {
      return getMovieList()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getTopRatedMovies() {
    if (getMovieList() != null && (getMovieList().isNotEmpty)) {
      return getMovieList()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getPopularMovies() {
    if (getMovieList() != null && (getMovieList().isNotEmpty)) {
      return getMovieList()
          .where((element) => element.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }
}
