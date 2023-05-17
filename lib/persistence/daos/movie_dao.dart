import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

abstract class MovieDao {
  void saveMovieList(List<MovieVO> movieList);

  void saveSingleMovie(MovieVO movie);
  List<MovieVO> getMovieList();

  MovieVO? getSingleMovie(int movieId);

  /// Reactive
  Stream<void> getAllMoviesEventStream();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  Stream<List<MovieVO>> getPopularMoviesStream();

  Stream<List<MovieVO>> getTopRatedMoviesStream();

  List<MovieVO> getNowPlayingMovies();

  List<MovieVO> getTopRatedMovies();

  List<MovieVO> getPopularMovies();
}
