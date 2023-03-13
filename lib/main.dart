import 'package:flutter/material.dart';
import 'package:movie_app_ui/persistence/hive_constants.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/collections_vo.dart';
import 'package:movie_app_ui/data.vos/vos/date_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_company_vo.dart';
import 'package:movie_app_ui/data.vos/vos/production_country_vo.dart';
import 'package:movie_app_ui/data.vos/vos/spoken_languages_vo.dart';
import 'package:movie_app_ui/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:movie_app_ui/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  // RetrofitDataAgentImpl().getNowPlayingMovies(1);
  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  // Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionsVOAdapter());
  // Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductinCompaniesVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguagesVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
