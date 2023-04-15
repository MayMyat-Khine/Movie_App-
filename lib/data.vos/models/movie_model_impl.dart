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

  MovieModelImpl._internal() {
    getNowPlayingMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getActors(1);
    getActorsFromDatabase();
    getGenres();
    getGenresFromDatabase();
  }

  // Daos
  final MovieDao _movieDao = MovieDao();
  final GenreDao _genreDao = GenreDao();
  final ActorDao _actorDao = ActorDao();

// Home Page State Variables
  List<MovieVO>? getNowPlayingMoviesList;
  List<MovieVO>? getPopularMoviesList;
  List<MovieVO>? getTopRatedMoviesList;
  List<MovieVO>? getmoviesByGenre;
  List<GenreVO>? getGenresList;
  List<ActorVO>? getActorsList;

  /// Movie Detail Page State Variable
  List<ActorVO>? casts = [];
  List<ActorVO>? crews = [];
  MovieVO? movieDetail;

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
  void getActors(int page) {
    _dataAgent.getActors(page).then((actorList) {
      if (actorList != null && actorList != []) {
        _actorDao.saveActorList(actorList);
      }
      getActorsList = actorList;
      notifyListeners();

      return actorList;
    });
  }

  @override
  void getGenres() {
    _dataAgent.getGenres().then((genreList) {
      if (genreList != null && genreList != []) {
        _genreDao.saveGenreList(genreList);
        getGenresList = genreList;

        getMoviesByGenre(genreList.first.id ?? 1);
      }
      notifyListeners();

      return genreList;
    });
  }

  @override
  void getMoviesByGenre(int genreId) {
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
  void getCreditsByMovie(int movieId) {
    _dataAgent.getCreditsByMovie(movieId).then((value) {
      casts = value.first;
      crews = value[1];
      notifyListeners();
    });
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) {
      _movieDao.saveSingleMovie(movie);
      movieDetail = movie;
      notifyListeners();
      return movie;
    });
  }

  /// Database
  @override
  void getActorsFromDatabase() {
    getActorsList = _actorDao.getActorList();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    getGenresList = _genreDao.getGenreList();
    notifyListeners();
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    movieDetail = _movieDao.getSingleMovie(movieId);
    notifyListeners();
  }

  @override
  void getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getNowPlayingMoviesStream())
        // .combineLatest(_movieDao.getNowPlayingMoviesStream(),
        //     (event, movieList) => movieList);
        .map((event) => _movieDao.getNowPlayingMovies())
        .first
        .then((value) {
      getNowPlayingMoviesList = value;
      notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getPopularMoviesStream())
        .map((event) => _movieDao.getPopularMovies())
        .first
        .then((value) {
      getPopularMoviesList = value;
      notifyListeners();
    });
    // .combineLatest(
    //     _movieDao.getPopularMoviesStream(), (event, movieList) => movieList)
    // .first;
    // return Future.value(_movieDao
    //     .getMovieList()
    //     .where((movie) => movie.isPopular ?? true)
    //     .toList());
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getTopRatedMoviesStream())
        .map((event) => _movieDao.getTopRatedMovies())
        .first
        .then((value) {
      getTopRatedMoviesList = value;
      notifyListeners();
    });
    // .combineLatest(_movieDao.getTopRatedMoviesStream(),
    //     (event, movieList) => movieList)
    // .first;
    // return Future.value(_movieDao
    //     .getMovieList()
    //     .where((movie) => movie.isTopRated ?? true)
    //     .toList());
  }
}
