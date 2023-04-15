import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ui/data.vos/models/movie_model.dart';
import 'package:movie_app_ui/data.vos/models/movie_model_impl.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/data.vos/vos/genre_vo.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/pages/movie_details_page.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/resources/strings.dart';
import 'package:movie_app_ui/views.dart/actors_view.dart';
import 'package:movie_app_ui/views.dart/banner_view.dart';
import 'package:movie_app_ui/views.dart/movie_view.dart';
import 'package:movie_app_ui/views.dart/show_case_view.dart';
import 'package:movie_app_ui/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app_ui/widgets/see_more_text.dart';
import 'package:movie_app_ui/widgets/title_text.dart';
import 'package:movie_app_ui/widgets/title_text_with_see_more_view.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return BannerSectionView(
                      movieList: model.getPopularMoviesList,
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return BestPopularMoviesAndSerialsSectionView(
                        (movieId) =>
                            _navigateToDetailScreen(context, movieId, model),
                        model.getNowPlayingMoviesList);
                  },
                ),
                CheckMovieShowTimeSectionView(),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return GenreSectionView(
                      (movieId) =>
                          _navigateToDetailScreen(context, movieId, model),
                      genreList: model.getGenresList,
                      moviesByGenreList: model.getmoviesByGenre,
                      onChooseGenre: (genreID) {
                        if (genreID != null) {
                          model.getMoviesByGenre(genreID);
                        }
                      },
                    );
                  },
                ),
                // HorizontalMovieListView(),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return ShowCasesSection(
                      movieList: model.getTopRatedMoviesList,
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return ActorsAndCreatorsSectionView(
                      BEST_ACTORS_TITLE,
                      BEST_ACTORS_SEE_MORE,
                      actorsList: model.getActorsList,
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ));
  }

  void _navigateToDetailScreen(
      BuildContext context, int? movieId, MovieModelImpl model) {
    model.getCreditsByMovie(movieId ?? 0);
    model.getMovieDetails(movieId ?? 0);
    model.getMovieDetailsFromDatabase(movieId ?? 0);
    if (movieId != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MovieDetailPage()));
    }
  }
}

class GenreSectionView extends StatelessWidget {
  GenreSectionView(this.onTapMovie,
      {required this.genreList,
      required this.moviesByGenreList,
      required this.onChooseGenre});

  final List<MovieVO>? moviesByGenreList;
  final List<GenreVO>? genreList;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map((genre) => Tab(
                            child: Text(genre.name ?? ""),
                          ))
                      .toList() ??
                  [],
              onTap: (index) {
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_BACKGROUND_COLOR,
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => onTapMovie(movieId),
            movieList: moviesByGenreList,
          ),
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
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            SeeMoreText(
              MAIN_SCREEN_SEE_MORE,
              textColor: PLAY_BUTTON_COLOR,
            )
          ],
        ),
        const Spacer(),
        const Icon(Icons.location_on_rounded,
            color: Colors.white, size: BANNER_PLAY_BUTTON_SIZE)
      ]),
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  final List<MovieVO>? movieList;
  ShowCasesSection({required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        SizedBox(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              children: movieList
                      ?.map((movie) => ShowCaseView(
                            movie: movie,
                          ))
                      .toList() ??
                  []),
        )
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? nowPlayingMovieList;
  const BestPopularMoviesAndSerialsSectionView(
      this.onTapMovie, this.nowPlayingMovieList,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) => onTapMovie(movieId),
          movieList: nowPlayingMovieList,
        ),
      ],
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? movieList;
  BannerSectionView({required this.movieList});
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
              children: widget.movieList?.getRange(0, 6).map((movie) {
                    return BannerView(
                      movie: movie,
                    );
                  }).toList() ??
                  []),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DotsIndicator(
              dotsCount: widget.movieList?.getRange(0, 6).length ??
                  1, // dotcount must be at least 1 or it might cause exception
              position: _position,
              decorator: const DotsDecorator(
                  color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
                  activeColor: PLAY_BUTTON_COLOR)),
        )
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList != null
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: ((BuildContext context, index) {
                return MovieView(
                  onTapMovie: () => onTapMovie(movieList?[index].id),
                  movie: movieList?[index],
                );
              }))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
