import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/resources/strings.dart';
import 'package:movie_app_ui/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app_ui/widgets/gradient_view.dart';
import 'package:movie_app_ui/widgets/rating_view.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(slivers: [
          MovieDetailsSliverAppBarView(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: TrailerSection(),
            ),
            ActorsAndCreatorsSectionView(
              MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
              "",
              seeMoreButtonVisibility: false,
            ),
            ActorsAndCreatorsSectionView(MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE)
          ]))
        ]),
      ),
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  const MovieDetailsSliverAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
        children: [
          Positioned.fill(
            child: MovieDetailsAppBarImageView(),
          ),
          Positioned.fill(child: GradientView()),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
              child: BackButtonView(),
            ),
          ),
          const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE + MARGIN_SMALL, right: MARGIN_MEDIUM_2),
                child: SearchButtonView(),
              )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE),
              child: MovieDetailAppBarInfoView(),
            ),
          )
        ],
      )),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  const MovieDetailsAppBarImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3_M8A2WLy8BR2DSRAaEq7gncMX2Jm8AyPwA&usqp=CAU",
      fit: BoxFit.cover,
    );
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MARGIN_XLARGE,
      height: MARGIN_XLARGE,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
      child: const Icon(
        Icons.chevron_left,
        color: Colors.white,
        size: MARGIN_LARGE,
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {
  const MovieDetailAppBarInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MovieDetailYearView(),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingView(),
                      SizedBox(
                        height: MARGIN_SMALL,
                      ),
                      TitleText("38876 VOTES"),
                      SizedBox(
                        height: MARGIN_MEDIUM,
                      )
                    ],
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM,
                  ),
                  Text(
                    "9,76",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            "Stranger Things",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_2X,
                fontWeight: FontWeight.bold),
          )
        ]);
  }
}

class MovieDetailYearView extends StatelessWidget {
  const MovieDetailYearView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XLARGE,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
          child: Text(
        "2016",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}

class TrailerSection extends StatelessWidget {
  const TrailerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Icon(
            Icons.access_time,
            color: PLAY_BUTTON_COLOR,
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          Text(
            "2h 30min",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      )
    ]);
  }
}
