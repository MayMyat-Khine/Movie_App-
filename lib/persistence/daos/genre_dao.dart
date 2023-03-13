import 'package:hive/hive.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

class GenreDao {
  static final GenreDao _singleton = GenreDao._internal();

  factory GenreDao() {
    return _singleton;
  }

  GenreDao._internal();

  void saveGenreList(List<GenreVO> genreList) async {
    Map<int, GenreVO> genreMap = Map.fromIterable(genreList,
        key: (genre) => genre.id, value: (genre) => genre);
    await getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getGenreList() {
    return getGenreBox().values.toList();
  }

  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}
