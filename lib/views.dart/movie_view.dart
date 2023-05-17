import 'package:flutter/material.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/constants.dart/api_constants.dart';
import 'package:movie_app_ui/widgets/rating_view.dart';

import '../resources/dimens.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieView extends StatelessWidget {
  final Function onTapMovie;
  final MovieVO? movie;
  MovieView({required this.onTapMovie, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_IIEM_WIDTH,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () => onTapMovie(),
          child: Image.network("$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
              height: 200, fit: BoxFit.cover),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        GestureDetector(
          onTap: () => onTapMovie(),
          child: Text(
            movie?.title ?? "",
            style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Row(
          children: const [
            Text(
              "8.9",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: MARGIN_MEDIUM),
            RatingView()
          ],
        )
      ]),
    );
  }
}
