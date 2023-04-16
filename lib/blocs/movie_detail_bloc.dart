import 'dart:async';

import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

class MovieDetailBloc {
  /// Stream Controllers
  StreamController<MovieVO> movieStreamController = StreamController();
  StreamController<List<ActorVO>> creatorsStreamController = StreamController();
  StreamController<List<ActorVO>> actorStreamController = StreamController();

  /// Models
  MovieModel movieModel = MovieModelImpl();

  MovieDetailBloc(int movieId) {
    /// Movie Detail From Network
    movieModel.getMovieDetails(movieId)?.then((movie) {
      movieStreamController.sink.add(movie);
    }).catchError((error) {});

    /// Movie Detail From Database
    // movieModel.getMovieDetailsFromDatabase(movieId)?.then((movie) {
    //   movieStreamController.sink.add(movie);
    // }).catchError((error) {});

    movieModel.getCreditsByMovie(movieId).then((creditsByMovie) {
      actorStreamController.sink.add(creditsByMovie.first ?? []);
      creatorsStreamController.sink.add(creditsByMovie[1] ?? []);
    }).catchError((error) {});
  }

  void disposeStream() {
    movieStreamController.close();
    creatorsStreamController.close();
    actorStreamController.close();
  }
}
