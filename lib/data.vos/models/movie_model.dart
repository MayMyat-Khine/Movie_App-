import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class MovieModel extends Model {
  // Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  void getGenres();
  void getMoviesByGenre(int genreId);
  void getActors(int page);
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);

  // Database
  void getNowPlayingMoviesFromDatabase();
  void getPopularMoviesFromDatabase();
  void getTopRatedMoviesFromDatabase();
  void getGenresFromDatabase();
  void getActorsFromDatabase();
  void getMovieDetailsFromDatabase(int movieId);
}
