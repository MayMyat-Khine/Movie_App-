import 'dart:async';

import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

class HomeBloc {
  /// Reactive Stream
  StreamController<List<MovieVO>> nowPlayingStreamController =
      StreamController();
  StreamController<List<MovieVO>> popularMovieListStreamController =
      StreamController();
  StreamController<List<GenreVO>> genreListStreamController =
      StreamController();
  StreamController<List<ActorVO>> actorStreamController = StreamController();
  StreamController<List<MovieVO>> showCaseMovieListStreamController =
      StreamController();
  StreamController<List<MovieVO>> moviesByGenreListStreamController =
      StreamController();

  /// Models
  MovieModel movieModel = MovieModelImpl();

  HomeBloc([MovieModel? movieModell]) {
    if (movieModell != null) {
      movieModel = movieModell;
    }

    /// Popular Movie List Database
    movieModel.getPopularMoviesFromDatabase().listen((movieList) {
      popularMovieListStreamController.sink.add(movieList ?? []);
    }).onError((error) {});

    /// Now Playing Movie List Database
    movieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingStreamController.sink.add(movieList ?? []);
    }).onError((error) {});

    /// Top Rated Movies From Database
    movieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      showCaseMovieListStreamController.sink.add(movieList ?? []);
    }).onError((error) {});

    /// Genres
    movieModel.getGenres().then((genreList) {
      genreListStreamController.sink.add(genreList ?? []);

      /// Movie by genre
      getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((error) {});

    /// Genres from Database
    movieModel.getGenresFromDatabase().then((genreList) {
      genreListStreamController.sink.add(genreList ?? []);

      /// Movie by genre
      getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((error) {});

    /// Actors
    movieModel.getActors(1).then((actorList) {
      actorStreamController.sink.add(actorList ?? []);
    }).catchError((error) {});

    /// Actors From Database
    movieModel.getActorsFromDatabase().then((actorList) {
      actorStreamController.sink.add(actorList ?? []);
    }).catchError((error) {});
  }

  void getMoviesByGenreAndRefresh(int id) {
    /// Movie by genre
    movieModel.getMoviesByGenre(id).then((movieList) {
      if (movieList != null) {
        moviesByGenreListStreamController.sink.add(movieList);
      }
    }).catchError((error) {});
  }

  void dispose() {
    nowPlayingStreamController.close();
    popularMovieListStreamController.close();
    genreListStreamController.close();
    actorStreamController.close();
    showCaseMovieListStreamController.close();
    moviesByGenreListStreamController.close();
  }
}
