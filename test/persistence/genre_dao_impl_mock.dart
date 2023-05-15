import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/persistence/daos/genre_dao.dart';

class GenreDaoImplMock extends GenreDao {
  Map<int, GenreVO> genreListFromDatabaseMock = {};
  @override
  List<GenreVO> getGenreList() {
    return genreListFromDatabaseMock.values.toList();
  }

  @override
  void saveGenreList(List<GenreVO> genreList) {
    genreList.forEach((genre) {
      genreListFromDatabaseMock[genre.id ?? 0] = genre;
    });
  }
}
