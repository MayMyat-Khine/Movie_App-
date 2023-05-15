import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/persistence/daos/movie_dao.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

class MovieDaoImpl extends MovieDao {
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  MovieDaoImpl._internal();

  @override
  void saveMovieList(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMovie(MovieVO movie) async {
    await getMovieBox().put(movie.id, movie);
  }

  @override
  List<MovieVO> getMovieList() {
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getSingleMovie(int movieId) {
    return getMovieBox().get(movieId);
  }

  /// Reactive
  @override
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getMovieList()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(
        getMovieList().where((element) => element.isPopular ?? false).toList());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getMovieList()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMovieList() != null && (getMovieList().isNotEmpty)) {
      return getMovieList()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if (getMovieList() != null && (getMovieList().isNotEmpty)) {
      return getMovieList()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
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
