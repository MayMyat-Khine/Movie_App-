import 'dart:io';

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
  MovieDetailPage({super.key});

  final List<String> genreList = ["Actions", "Adventure", "Thriller"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(slivers: [
          MovieDetailsSliverAppBarView(() => Navigator.pop(context)),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: TrailerSection(genreList),
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            ActorsAndCreatorsSectionView(
              MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
              "",
              seeMoreButtonVisibility: false,
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: AboutFilmSectionView(),
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            ActorsAndCreatorsSectionView(MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE)
          ]))
        ]),
      ),
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;
  AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
                color: MOVIE_DETAIL_INFO_TEXT_COLOR,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
                color: Colors.white,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  MovieDetailsSliverAppBarView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
        children: [
          Positioned.fill(
            child: MovieDetailsAppBarImageView(),
          ),
          Positioned.fill(child: GradientView()),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
              child: BackButtonView(onTapBack),
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
  final Function onTapBack;
  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => onTapBack()),
      child: Container(
        width: MARGIN_XLARGE,
        height: MARGIN_XLARGE,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_LARGE,
        ),
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
  TrailerSection(this.genreList);
  final List<String> genreList;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MovieTimeAndGenreView(genreList),
      SizedBox(
        height: MARGIN_MEDIUM_3,
      ),
      StorylineView(),
      SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      Row(
        children: [
          MovieDetailScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_filled,
                color: Colors.black54,
              )),
          SizedBox(width: MARGIN_CARD_MEDIUM_2),
          MovieDetailScreenButtonView(
            "RATE MOVIE",
            HOME_SCREEN_BACKGROUND_COLOR,
            Icon(
              Icons.star,
              color: PLAY_BUTTON_COLOR,
            ),
            isGhostButton: true,
          ),
        ],
      )
    ]);
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
            backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        // SizedBox(
        //   width: MARGIN_SMALL,
        // )
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  final List<String> genreList;
  MovieTimeAndGenreView(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        SizedBox(
          child: Row(
            children: genreList.map((genre) => GenreChipView(genre)).toList(),
          ),
        ),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class StorylineView extends StatelessWidget {
  const StorylineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          "On November 6, 1983 in Hawkins, Indiana, a scientist is attacked by an unseen creature at a U.S. government laboratory. 12-year-old Will Byers encounters the creature and mysteriously vanishes while cycling home from a Dungeons & Dragons session with his friends Mike Wheeler, Dustin Henderson and Lucas Sinclair",
          style: TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
        )
      ],
    );
  }
}

class MovieDetailScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailScreenButtonView(this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border:
            isGhostButton ? Border.all(color: Colors.white, width: 2) : null,
      ),
      height: MARGIN_XXLARGE,
      child: Center(
          child: Row(
        children: [
          buttonIcon,
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleText("ABOUT FILM"),
      SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Original Title", "Stranger Things 2"),
      SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("TYPE", "Action , Adventure , Thriller"),
      SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("PRoduction", "United Kindom USA"),
      SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Premiere", "8 Nov 2016 (World)"),
      SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Description",
          "The new Starcourt Mall has become the center of attention for Hawkins residents, putting the majority of other local stores out of business due to the mall's popularity. Hopper becomes increasingly concerned about Eleven and Mike's relationship and becomes very protective of his daughter. "),
    ]);
  }
}
