import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/resources/strings.dart';
import 'package:movie_app_ui/views.dart/actors_view.dart';
import 'package:movie_app_ui/views.dart/banner_view.dart';
import 'package:movie_app_ui/views.dart/movie_view.dart';
import 'package:movie_app_ui/views.dart/show_case_view.dart';
import 'package:movie_app_ui/widgets/see_more_text.dart';
import 'package:movie_app_ui/widgets/title_text.dart';
import 'package:movie_app_ui/widgets/title_text_with_see_more_view.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];
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
          title: Text(
            APP_BAR_TITLE,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BannerSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                BestPopularMoviesAndSerialsSectionView(),
                CheckMovieShowTimeSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                GenreSectionView(genreList: genreList),
                // HorizontalMovieListView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                ShowCasesSection(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                BestActorSectionView(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ));
  }
}

class GenreSectionView extends StatelessWidget {
  const GenreSectionView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map((e) => Tab(
                        child: Text(e),
                      ))
                  .toList(),
            ),
          ),
        ),
        Container(
          color: PRIMARY_BACKGROUND_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(),
        )
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_BACKGROUND_COLOR,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            SeeMoreText(
              MAIN_SCREEN_SEE_MORE,
              textColor: PLAY_BUTTON_COLOR,
            )
          ],
        ),
        Spacer(),
        Icon(Icons.location_on_rounded,
            color: Colors.white, size: BANNER_PLAY_BUTTON_SIZE)
      ]),
    );
  }
}

class BestActorSectionView extends StatelessWidget {
  const BestActorSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_BACKGROUND_COLOR,
      padding: EdgeInsets.only(top:MARGIN_MEDIUM_2,bottom:MARGIN_XXLARGE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child:
                TitleTextWithSeeMoreView(BEST_ACTORS_TITLE, BEST_ACTORS_SEE_MORE),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Container(
            height: BEST_ACTORS_HEIGHT,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                children: [
                  ActorsView(),
                  ActorsView(),
                  ActorsView(),
                ]),
          ),
        ],
      ),
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  const ShowCasesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              children: [
                ShowCaseView(),
                ShowCaseView(),
                ShowCaseView(),
              ]),
        )
      ],
    );
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

class BannerSectionView extends StatefulWidget {
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
              onPageChanged: (page) {
                setState(() {
                  _position = page.toDouble();
                });
              },
              children: [
                BannerView(),
                BannerView(),
              ]),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        DotsIndicator(
            dotsCount: 2,
            position: _position,
            decorator: DotsDecorator(
                color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
                activeColor: PLAY_BUTTON_COLOR))
      ],
    );
  }
}
