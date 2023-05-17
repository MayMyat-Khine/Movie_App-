import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/collections_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_company_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_country_vo.dart';
import 'package:movie_app_ui/data.vos/vos/spoken_languages_vo.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
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
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(
        true,
        2,
        2,
        [
          MovieVO(
              false,
              "",
              [1, 2, 3],
              1,
              "English",
              "Movie Title",
              "ABout movie",
              2.2,
              "posterPath",
              "12-12-2022",
              "Movie Title",
              false,
              10.1,
              10,
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
              true,
              false,
              false),
        ],
        "knownForDepartment",
        "name",
        2.2,
        "profilePath",
        "originalName",
        3,
        "character",
        "creditId",
        4),
    ActorVO(
        true,
        2,
        1,
        [
          MovieVO(
              false,
              "",
              [1, 2, 3],
              1,
              "English",
              "Movie Title",
              "ABout movie",
              2.2,
              "posterPath",
              "12-12-2022",
              "Movie Title",
              false,
              10.1,
              10,
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
              true,
              false,
              false),
        ],
        "knownForDepartment",
        "name",
        2.2,
        "profilePath",
        "originalName",
        3,
        "character",
        "creditId",
        4)
  ];
}

List<GenreVO> getMockGenres() {
  return [GenreVO(2, "romance"), GenreVO(1, "name"), GenreVO(3, "thriller")];
}

List<List<ActorVO>> getMockCredits() {
  return [
    [
      ActorVO(
          false,
          2,
          2,
          [
            MovieVO(
                false,
                "",
                [1, 2, 3],
                1,
                "English",
                "Movie Title",
                "ABout movie",
                2.2,
                "posterPath",
                "12-12-2022",
                "Movie Title",
                false,
                10.1,
                10,
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
                true,
                false,
                false),
          ],
          "knownForDepartment",
          "name",
          2.2,
          "profilePath",
          "originalName",
          3,
          "Actor",
          "creditId",
          4),
      ActorVO(
          false,
          2,
          2,
          [
            MovieVO(
                false,
                "",
                [1, 2, 3],
                1,
                "English",
                "Movie Title",
                "ABout movie",
                2.2,
                "posterPath",
                "12-12-2022",
                "Movie Title",
                false,
                10.1,
                10,
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
                true,
                false,
                false),
          ],
          "knownForDepartment",
          "name",
          2.2,
          "profilePath",
          "originalName",
          3,
          "Crew",
          "creditId",
          4)
    ]
  ];
}
