import 'package:flutter/material.dart';
import 'package:movie_app_ui/network/retrofit_data_agent_impl.dart';
import 'package:movie_app_ui/pages/home_page.dart';

void main() {
  RetrofitDataAgentImpl().getNowPlayingMovies(1);
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
