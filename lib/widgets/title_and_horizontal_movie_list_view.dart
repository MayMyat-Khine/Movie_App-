import 'package:flutter/material.dart';
import 'package:movie_app_ui/component/smart_horizontal_list_view.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/resources/strings.dart';
import 'package:movie_app_ui/views.dart/movie_view.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? nowPlayingMovieList;
  final String title;
  final Function onListEndReached;
  const BestPopularMoviesAndSerialsSectionView(
      this.onTapMovie, this.nowPlayingMovieList,
      {super.key, required this.title, required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) => onTapMovie(movieId),
          movieList: nowPlayingMovieList,
          onListEndReached: onListEndReached,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  final Function onListEndReached;
  HorizontalMovieListView(
      {required this.onTapMovie,
      required this.movieList,
      required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList != null
          ?
          // ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          //     itemCount: movieList?.length ?? 0,
          //     itemBuilder: ((BuildContext context, index) {
          //       return MovieView(
          //         onTapMovie: () => onTapMovie(movieList?[index].id),
          //         movie: movieList?[index],
          //       );
          //     }))

          SmartHorizontalListView(
              itemCount: movieList?.length ?? 0,
              itemBuilder: ((BuildContext context, index) {
                return MovieView(
                  onTapMovie: () => onTapMovie(movieList?[index].id),
                  movie: movieList?[index],
                );
              }),
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              onListEndReached: onListEndReached)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
