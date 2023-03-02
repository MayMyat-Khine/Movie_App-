import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';

abstract class MovieDateAgent {
  Future<List<MovieVO>?> getNowPlayingMovies(int page);
}
