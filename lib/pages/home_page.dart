import 'package:flutter/material.dart';
import 'package:movie_app_ui/views.dart/banner_view.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../views.dart/movie_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          leading: const Icon(Icons.menu),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                  left: 0, top: 0, bottom: 0, right: MARGIN_MEDIUM_2),
              child: Icon(
                Icons.search,
              ),
            )
          ],
          title: const Text(
            APP_BAR_TITLE,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          color: PRIMARY_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BannerSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                BestPopularMoviesAndSerialsSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                HorizontalMovieListView()
              ],
            ),
          ),
        ));
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  const BestPopularMoviesAndSerialsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(),
      ],
    );
  }
}

class BannerSectionView extends StatelessWidget {
  const BannerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: PageView(children: [
        BannerView(),
        BannerView(),
      ]),
    );
  }
}
