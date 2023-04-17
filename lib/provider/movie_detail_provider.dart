import 'package:flutter/material.dart';
import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

class MovieDetailProvider extends ChangeNotifier {
  /// State Variables
  List<ActorVO>? casts = [];
  List<ActorVO>? crews = [];
  MovieVO? movieDetail;

  /// Model
  final MovieModel _movieModel = MovieModelImpl();

  MovieDetailProvider(int movieId) {
    // Movie Detail From Network
    _movieModel.getMovieDetails(movieId)?.then((movie) {
      movieDetail = movie;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

// Movie Detail From Database
    _movieModel.getMovieDetailsFromDatabase(movieId)?.then((movie) {
      movieDetail = movie;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    _movieModel.getCreditsByMovie(movieId).then((creditsByMovie) {
      casts = creditsByMovie.first;
      crews = creditsByMovie[1];
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}
