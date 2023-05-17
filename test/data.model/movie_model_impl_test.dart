import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/collections_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_company_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_country_vo.dart';
import 'package:movie_app_ui/data.vos/vos/spoken_languages_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/actor_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(MovieDaoImplMock(), ActorDaoImplMock(),
          GenreDaoImplMock(), MovieDataAgentImplMock());
    });
   
    test(
        "Saving Now Playing Movies and Getting Now Playing Movies From Mock Database",
        () {
      expect(
          movieModel.getNowPlayingMoviesFromDatabase(),
          emits([
            MovieVO(
                false,
                "/aAgGrfBwna1nO4M2USxwFgK5O0t.jpg",
                [27, 53, 14],
                1,
                "en",
                "Evil Dead Rise",
                "Three siblings find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                5956.719,
                "/5ik4ATKmNtmJU6AYD0bLm56BCVM.jpg",
                "2023-04-12",
                "Evil Dead Rise",
                false,
                7.2,
                812,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                true,
                false,
                false),
          ]));
    });

    test(
        "Saving Top Rated  Movies and Getting Top Rated Movies From Mock Database",
        () {
      expect(
          movieModel.getTopRatedMoviesFromDatabase(),
          emits([
            MovieVO(
                true,
                "",
                [1, 2, 3],
                1,
                "English",
                "Movie Title",
                "ABout movie",
                3.2,
                "posterPath",
                "12-12-2012",
                "Movie Title",
                false,
                10.1,
                10,
                CollectionsVO(2, "name", "posterpath", 'packdroppath'),
                2.2,
                [GenreVO(2, "romace")],
                "homepage",
                "imdbId",
                [ProductionCompaniesVO(3, "logoPath", "name", "originCountry")],
                [ProductionCountryVO("iso", "name")],
                1,
                1,
                [SpokenLanguagesVO("englishName", "iso", "name")],
                "status",
                'tagLine',
                false,
                true,
                false),
          ]));
    });

    test(
        "Saving Popular  Movies and Getting Popular  Movies From Mock Database",
        () {
      expect(
          movieModel.getPopularMoviesFromDatabase(),
          emits([
            MovieVO(
                false,
                "",
                [1, 4, 3],
                1,
                "English",
                "Movie Title",
                "ABout movie",
                2.2,
                "posterPath",
                "12-12-2022",
                "Movie Title",
                false,
                20.1,
                3,
                CollectionsVO(1, "name", "posterpath", 'packdroppath'),
                2.2,
                [GenreVO(1, "romace")],
                "homepage",
                "imdbId",
                [ProductionCompaniesVO(1, "logoPath", "name", "originCountry")],
                [ProductionCountryVO("iso", "name")],
                1,
                1,
                [SpokenLanguagesVO("englishName", "iso", "name")],
                "status",
                'tagLine',
                false,
                false,
                true)
          ]));
    });

    test("Get Genres Test", () {
      expect(movieModel.getGenres(), completion(equals(getMockGenres())));
    });

    test("Get Actors Test", () {
      expect(movieModel.getActors(1), completion(equals(getMockActors())));
    });

    test("Get Credits Test", () {
      expect(movieModel.getCreditsByMovie(1),
          completion(equals(getMockCredits())));
    });

    test("Get Movie Detail Test", () {
      expect(movieModel.getMovieDetails(1),
          completion(equals(getMockMoviesForTest().first)));
    });

    test("Get Actors from Database Test", () async {
      await movieModel.getActors(1);
      expect(movieModel.getActorsFromDatabase(),
          completion(equals(getMockActors())));
    });

    test("Get Movie Detail from Database Test", () async {
      await movieModel.getMovieDetails(1);
      expect(movieModel.getMovieDetailsFromDatabase(1),
          completion(equals(getMockMoviesForTest().first)));
    });

    test("Get Genres from Database Test", () async {
      await movieModel.getGenres();
      expect(movieModel.getGenresFromDatabase(),
          completion(equals(getMockGenres())));
    });
  });
}
