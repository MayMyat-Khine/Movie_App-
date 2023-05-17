import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_ui/provider/home_provider.dart';

import '../data.model/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group("Home Page Test", () {
    HomeProvider? homeProvider;
    setUp(() => homeProvider = HomeProvider(
        MovieModelImplMock())); // assign the homeproviderobj here create each new instance everytime one test function is called and it is best pratice for if the upcoming calling data depend on previous one calling result

    test("Fetch Now Playing Movie List", () {
      expect(
          homeProvider?.nowPlayingMovies
              ?.contains(getMockMoviesForTest().first),
          true);
    });

    test("Fetch Popular Movie List", () {
      expect(homeProvider?.popularMovies?.contains(getMockMoviesForTest().last),
          true);
    });

    test("Fetch TopRated Movie List", () {
      expect(homeProvider?.topRatedMovies?.contains(getMockMoviesForTest()[1]),
          true);
    });

    test("Fetch Actors  List", () {
      expect(homeProvider?.actors?.contains(getMockActors().first), true);
    });

    test("Fetch Genres  List", () {
      expect(homeProvider?.genres?.contains(getMockGenres().first), true);
    });

    test("Fetch Initial Movies By Geners Test", () async {
      await Future.delayed(const Duration(microseconds: 500));
      expect(
          homeProvider?.moviesByGenre?.contains(getMockMoviesForTest().first),
          true);
    });

    test("Fetch  Movies From User Input Test", () async {
      await Future.delayed(const Duration(
          microseconds:
              500)); // first fetch id with await and second fetch related movie, so need to wait a little bit of time between two await function, so that there might have data for second funtion from first await funtion to run

      homeProvider?.onTapGenre(3);
      expect(
          homeProvider?.moviesByGenre?.contains(getMockMoviesForTest().first),
          true);
    });
  });
}
