import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/constants.dart/api_constants.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/resources/strings.dart';
import 'package:movie_app_ui/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app_ui/widgets/gradient_view.dart';
import 'package:movie_app_ui/widgets/rating_view.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  MovieDetailPage({required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final List<String> genreList = ["Actions", "Adventure", "Thriller"];
  //State Variables
  final MovieModel _movieModel = MovieModelImpl();
  List<ActorVO>? casts = [];
  List<ActorVO>? crews = [];
  MovieVO? movieDetail;
  @override
  void initState() {
    // Movie Detail From Network
    // _movieModel.getMovieDetails(widget.movieId)?.then((movie) {
    //   setState(() {
    //     movieDetail = movie;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

// Movie Detail From Database
    _movieModel.getMovieDetailsFromDatabase(widget.movieId)?.then((movie) {
      setState(() {
        movieDetail = movie;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    _movieModel.getCreditsByMovie(widget.movieId).then((creditsByMovie) {
      setState(() {
        casts = creditsByMovie.first;
        crews = creditsByMovie[1];
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(slivers: [
          MovieDetailsSliverAppBarView(
            () => Navigator.pop(context),
            movieDetail: movieDetail,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: TrailerSection(
                genreList: movieDetail?.getGenreListAsStringList() ?? [],
                storyLine: movieDetail?.overview ?? "",
              ),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            ActorsAndCreatorsSectionView(
              MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
              "",
              seeMoreButtonVisibility: false,
              actorsList: casts,
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: AboutFilmSectionView(movieDetail: movieDetail),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            ActorsAndCreatorsSectionView(
              MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
              MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
              actorsList: crews,
            )
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
            style: const TextStyle(
                color: MOVIE_DETAIL_INFO_TEXT_COLOR,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
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
  final MovieVO? movieDetail;
  MovieDetailsSliverAppBarView(this.onTapBack, {required this.movieDetail});
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
            child: MovieDetailsAppBarImageView(
              imageUrl: movieDetail?.posterPath ?? "",
            ),
          ),
          const Positioned.fill(child: GradientView()),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
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
              padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE),
              child: MovieDetailAppBarInfoView(movieDetail: movieDetail),
            ),
          )
        ],
      )),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  final String? imageUrl;
  MovieDetailsAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
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
  final MovieVO? movieDetail;
  MovieDetailAppBarInfoView({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MovieDetailYearView(
                  year: movieDetail?.releaseDate?.substring(0, 4) ?? ""),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const RatingView(),
                      const SizedBox(
                        height: MARGIN_SMALL,
                      ),
                      TitleText("${movieDetail?.voteCount} VOTES"),
                      const SizedBox(
                        height: MARGIN_MEDIUM,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: MARGIN_MEDIUM,
                  ),
                  Text(
                    movieDetail?.voteAverage.toString() ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            movieDetail?.title ?? "",
            style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_2X,
                fontWeight: FontWeight.bold),
          )
        ]);
  }
}

class MovieDetailYearView extends StatelessWidget {
  final String? year;
  MovieDetailYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XLARGE,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
          child: Text(
        year ?? "",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}

class TrailerSection extends StatelessWidget {
  TrailerSection({required this.genreList, required this.storyLine});
  final List<String> genreList;
  final String storyLine;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MovieTimeAndGenreView(genreList),
      const SizedBox(
        height: MARGIN_MEDIUM_3,
      ),
      StorylineView(storyLine: storyLine),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      Row(
        children: [
          MovieDetailScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              const Icon(
                Icons.play_circle_filled,
                color: Colors.black54,
              )),
          const SizedBox(width: MARGIN_CARD_MEDIUM_2),
          MovieDetailScreenButtonView(
            "RATE MOVIE",
            HOME_SCREEN_BACKGROUND_COLOR,
            const Icon(
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
            backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          width: MARGIN_SMALL,
        )
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  final List<String> genreList;
  MovieTimeAndGenreView(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisSize: MainAxisSize.min,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        const Text(
          "2h 30min",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        ...genreList.map((genre) => GenreChipView(genre)).toList(),
        // const Spacer(),
        const Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class StorylineView extends StatelessWidget {
  final String storyLine;
  StorylineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          storyLine,
          style:
              const TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
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
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
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
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            title,
            style: const TextStyle(
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
  final MovieVO? movieDetail;
  AboutFilmSectionView({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TitleText("ABOUT FILM"),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Original Title", movieDetail?.title ?? ""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView(
          "TYPE", movieDetail?.getGenreListAsCommaSeperatedString() ?? ""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Production",
          movieDetail?.getProductionCountriedAsCommaSeperatedString() ?? ""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Premiere", movieDetail?.releaseDate ?? ""),
      const SizedBox(
        height: MARGIN_MEDIUM_2,
      ),
      AboutFilmInfoView("Description", movieDetail?.overview ?? ""),
    ]);
  }
}
