import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';
import 'package:movie_app_ui/network/data_agents/retrofit_data_agent_impl.dart';

class MovieModelImpl extends MovieModel {
  MovieDateAgent _dataAgent =
      RetrofitDataAgentImpl(); //MovieDateAgent as a dependency

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return _dataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return _dataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return _dataAgent.getTopRatedMovies(page);
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId);
  }
}
