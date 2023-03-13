import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';
import 'package:movie_app_ui/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:movie_app_ui/persistence/daos/actor_dao.dart';
import 'package:movie_app_ui/persistence/daos/genre_dao.dart';
import 'package:movie_app_ui/persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel {
  MovieDateAgent _dataAgent =
      RetrofitDataAgentImpl(); //MovieDateAgent as a dependency

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  // Daos
  final MovieDao _movieDao = MovieDao();
  final GenreDao _genreDao = GenreDao();
  final ActorDao _actorDao = ActorDao();

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return _dataAgent.getNowPlayingMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> nowPlayingMovies = movies.map((movie) {
          movie.isNowPlaying = true;
          movie.isPopular = false;
          movie.isTopRated = false;
          return movie;
        }).toList();
        _movieDao.saveMovieList(nowPlayingMovies);
      }
      return movies;
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page).then((actorList) {
      if (actorList != null && actorList != []) {
        _actorDao.saveActorList(actorList);
      }
      return actorList;
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genreList) {
      if (genreList != null && genreList != []) {
        _genreDao.saveGenreList(genreList);
      }
      return genreList;
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return _dataAgent.getNowPlayingMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> nowPlayingMovies = movies.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = true;
          movie.isTopRated = false;
          return movie;
        }).toList();
        _movieDao.saveMovieList(nowPlayingMovies);
      }
      return movies;
    });
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return _dataAgent.getTopRatedMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> nowPlayingMovies = movies.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = false;
          movie.isTopRated = true;
          return movie;
        }).toList();
        _movieDao.saveMovieList(nowPlayingMovies);
      }
      return movies;
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) {
      _movieDao.saveSingleMovie(movie);
      return movie;
    });
  }

  @override
  Future<List<ActorVO>?> getActorsFromDatabase(int page) {
    return Future.value(_actorDao.getActorList());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(_genreDao.getGenreList());
  }

  @override
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId) {
    return Future.value(_movieDao.getSingleMovie(movieId));
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase(int page) {
    return Future.value(_movieDao
        .getMovieList()
        .where((movie) => movie.isNowPlaying ?? true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getPopularMoviesFromDatabase(int page) {
    return Future.value(_movieDao
        .getMovieList()
        .where((movie) => movie.isPopular ?? true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase(int page) {
    return Future.value(_movieDao
        .getMovieList()
        .where((movie) => movie.isTopRated ?? true)
        .toList());
  }
}
