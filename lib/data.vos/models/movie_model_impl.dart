import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/movie_data_agent.dart';
import 'package:movie_app_ui/network/retrofit_data_agent_impl.dart';

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
}
