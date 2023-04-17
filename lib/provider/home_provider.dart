
import 'package:flutter/material.dart';
import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

class HomeProvider extends ChangeNotifier {
  /// State Variables
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// Model
  MovieModel movieModel = MovieModelImpl();

  HomeProvider() {
    /// Popular Movies From Database
    movieModel.getPopularMoviesFromDatabase().listen((movieList) {
      popularMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Now Playing Movies From Database
    movieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Top Rated Movies From Database
    movieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      topRatedMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Genres
    movieModel.getGenres().then((genreList) {
      genres = genreList;
      notifyListeners();

      /// Movies By Genre
      getMoviesByGenre(genres?.first.id ?? 1);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Genres from Database
    movieModel.getGenresFromDatabase().then((genreList) {
      genres = genreList;
      notifyListeners();

      /// Movies By Genre
      getMoviesByGenre(genres?.first.id ?? 1);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors
    movieModel.getActors(1).then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors From
    movieModel.getActorsFromDatabase().then((actorList) {
      actors = actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapGenre(genreId) {
    getMoviesByGenre(genreId);
  }

  void getMoviesByGenre(int genreId) {
    movieModel.getMoviesByGenre(genreId)?.then((movieList) {
      moviesByGenre = movieList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
