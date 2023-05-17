import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_ui/provider/movie_detail_provider.dart';

import '../data.model/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group('Movie Details Test', () {
    MovieDetailProvider? movieDetailProvider;
    setUp(() =>
        movieDetailProvider = MovieDetailProvider(1, MovieModelImplMock()));

    test("Fetch Movie Detail Test", () {
      expect(movieDetailProvider?.movieDetail, getMockMoviesForTest().first);
    });

    test("Fetch Crews Test", () {
      expect(movieDetailProvider?.crews?.contains(getMockCredits().first[1]),
          true);
    });

    test("Fetch Actors Test", () {
      expect(movieDetailProvider?.casts?.contains(getMockCredits().first[0]),
          true);
    });
  });
}
