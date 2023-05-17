import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class MovieModel extends Model {
  // Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  // Database
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase();
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getActorsFromDatabase();
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);
}
