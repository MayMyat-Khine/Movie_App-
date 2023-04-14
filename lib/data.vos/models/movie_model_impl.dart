import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';
import 'package:movie_app_ui/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:movie_app_ui/persistence/daos/actor_dao.dart';
import 'package:movie_app_ui/persistence/daos/genre_dao.dart';
import 'package:movie_app_ui/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDateAgent _dataAgent =
      RetrofitDataAgentImpl(); //MovieDateAgent as a dependency

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal() {}

  // Daos
  final MovieDao _movieDao = MovieDao();
  final GenreDao _genreDao = GenreDao();
  final ActorDao _actorDao = ActorDao();

// State Variables
  List<MovieVO>? getNowPlayingMoviesList;
  List<MovieVO>? getPopularMoviesList;
  List<MovieVO>? getTopRatedMoviesList;
  List<MovieVO>? getmoviesByGenre;
  List<GenreVO>? getGenresList;
  List<ActorVO>? getActorsList;

  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> nowPlayingMovies = movies.map((movie) {
          movie.isNowPlaying = true;
          movie.isPopular = false;
          movie.isTopRated = false;
          return movie;
        }).toList();
        _movieDao.saveMovieList(nowPlayingMovies);
        getNowPlayingMoviesList = nowPlayingMovies;
        notifyListeners();
      }
      // return movies;
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page).then((actorList) {
      if (actorList != null && actorList != []) {
        _actorDao.saveActorList(actorList);
      }
      getActorsList = actorList;
      notifyListeners();

      return actorList;
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genreList) {
      if (genreList != null && genreList != []) {
        _genreDao.saveGenreList(genreList);
        getGenresList = genreList;

        getMoviesByGenre(genreList.first.id ?? 1)?.then((value) {
          getmoviesByGenre = value;
          notifyListeners();
        });
      }
      notifyListeners();

      return genreList;
    });
  }

  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId) {
    _dataAgent.getMoviesByGenre(genreId).then((value) {
      getmoviesByGenre = value;
      notifyListeners();
    });
  }

  @override
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> popularMovies = movies.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = true;
          movie.isTopRated = false;
          return movie;
        }).toList();
        _movieDao.saveMovieList(popularMovies);
        getPopularMoviesList = popularMovies;
        notifyListeners();
      }
      // return movies;
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> topRatedMovies = movies.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = false;
          movie.isTopRated = true;
          return movie;
        }).toList();
        _movieDao.saveMovieList(topRatedMovies);
        getTopRatedMoviesList = topRatedMovies;
        notifyListeners();
      }
      // return movies;
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

  /// Database
  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
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
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    return _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getNowPlayingMoviesStream())
        // .combineLatest(_movieDao.getNowPlayingMoviesStream(),
        //     (event, movieList) => movieList);
        .map((event) => _movieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getPopularMoviesStream())
        .map((event) => _movieDao.getPopularMovies());
    // .combineLatest(
    //     _movieDao.getPopularMoviesStream(), (event, movieList) => movieList)
    // .first;
    // return Future.value(_movieDao
    //     .getMovieList()
    //     .where((movie) => movie.isPopular ?? true)
    //     .toList());
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getTopRatedMoviesStream())
        .map((event) => _movieDao.getTopRatedMovies());
    // .combineLatest(_movieDao.getTopRatedMoviesStream(),
    //     (event, movieList) => movieList)
    // .first;
    // return Future.value(_movieDao
    //     .getMovieList()
    //     .where((movie) => movie.isTopRated ?? true)
    //     .toList());
  }
}
