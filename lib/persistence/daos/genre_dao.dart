import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

abstract class GenreDao {
  void saveGenreList(List<GenreVO> genreList);

  List<GenreVO> getGenreList();
}
