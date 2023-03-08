import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';
import 'package:movie_app_ui/network/data_agents/retrofit_data_agent_impl.dart';

class MovieModelImpl extends MovieModel {
  MovieDateAgent mDataAgent =
      RetrofitDataAgentImpl(); //MovieDateAgent as a dependency

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mDataAgent.getActors(page);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mDataAgent.getGenres();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mDataAgent.getTopRatedMovies(page);
  }
}
