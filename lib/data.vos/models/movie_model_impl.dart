import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/data_agents/movie_data_agent.dart';
import 'package:movie_app_ui/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:movie_app_ui/persistence/daos/actor_dao.dart';
import 'package:movie_app_ui/persistence/daos/genre_dao.dart';
import 'package:movie_app_ui/persistence/daos/impls/actor_dao_imple.dart';
import 'package:movie_app_ui/persistence/daos/impls/genre_dao_imple.dart';
import 'package:movie_app_ui/persistence/daos/impls/movie_dao_imple.dart';
import 'package:movie_app_ui/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDateAgent _dataAgent =
      RetrofitDataAgentImpl(); //MovieDateAgent as a dependency

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  // Daos
  MovieDao _movieDao = MovieDaoImpl();
  GenreDao _genreDao = GenreDaoImpl();
  ActorDao _actorDao = ActorDaoImpl();

  /// For Testing Purpose
  void setDaosAndDataAgents(MovieDao movieDao, ActorDao actorDao,
      GenreDao genreDao, MovieDateAgent dateAgent) {
    _dataAgent = dateAgent;
    _movieDao = movieDao;
    _actorDao = actorDao;
    _genreDao = genreDao;
  }

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
        // nowPlayingMovies.forEach((element) {
        //   print(element.toJson());
        //   print(MovieVO(
        //       element.adult,
        //       element.backDropPath,
        //       element.genreIds,
        //       element.id,
        //       element.originalLanguage,
        //       element.originalTitle,
        //       element.overview,
        //       element.popularity,
        //       element.posterPath,
        //       element.releaseDate,
        //       element.title,
        //       element.video,
        //       element.voteAverage,
        //       element.voteCount,
        //       element.belongsToCollection,
        //       element.budget,
        //       element.genres,
        //       element.homepage,
        //       element.imdbId,
        //       element.productionCompanies,
        //       element.productionCountry,
        //       element.revenue,
        //       element.runtime,
        //       element.spokenLanguages,
        //       element.status,
        //       element.tagLine,
        //       element.isNowPlaying,
        //       element.isTopRated,
        //       element.isPopular));
        // });
        _movieDao.saveMovieList(nowPlayingMovies);
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
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> nowPlayingMovies = movies.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = true;
          movie.isTopRated = false;

          return movie;
        }).toList();
        _movieDao.saveMovieList(nowPlayingMovies);
      }
      // return movies;
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) {
      if (movies != null && movies != []) {
        List<MovieVO> nowPlayingMovies = movies.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = false;
          movie.isTopRated = true;
          return movie;
        }).toList();
        _movieDao.saveMovieList(nowPlayingMovies);
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
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    return _movieDao
        .getAllMoviesEventStream()
        .startWith(_movieDao.getNowPlayingMoviesStream())
        // .combineLatest(_movieDao.getNowPlayingMoviesStream(),
        //     (event, movieList) => movieList);
        .map((event) => _movieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
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
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
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
