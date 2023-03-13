import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

abstract class MovieModel {
  // Network
  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getPopularMovies(int page);
  Future<List<MovieVO>?> getTopRatedMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  // Database
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page);
  Future<List<MovieVO>?> getPopularMoviesFromDatabase(int page);
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase(int page);
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getActorsFromDatabase(int page);
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);
}
