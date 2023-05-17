import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/collections_vo.dart';
import 'package:movie_app_ui/data.vos/vos/date_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_company_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_country_vo.dart';
import 'package:movie_app_ui/data.vos/vos/spoken_languages_vo.dart';
import 'package:movie_app_ui/main.dart';
import 'package:movie_app_ui/pages/home_page.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionsVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductinCompaniesVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguagesVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);

  testWidgets("Tap Best Popular Movies and Navigate to its details",
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await widgetTester.pumpAndSettle(Duration(seconds: 15));
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);

    await widgetTester.tap(find.text(TEST_DATA_MOVIE_NAME));
    await widgetTester.pumpAndSettle(Duration(seconds: 15));

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_RATING), findsOneWidget);
    expect(find.text(TEST_DATA_RELEASED_YEAR), findsOneWidget);
  });
}
