import 'package:flutter/material.dart';
import 'package:movie_app_ui/widgets/rating_view.dart';

import '../resources/dimens.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;
  HorizontalMovieListView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: 5,
          itemBuilder: ((BuildContext context, index) {
            return Container(
              margin: EdgeInsets.only(right: MARGIN_MEDIUM),
              width: MOVIE_LIST_IIEM_WIDTH,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => onTapMovie(),
                      child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGEaNeD1QdMG1bclIop7bMvBbxgIrsWutMxQ&usqp=CAU",
                          height: 200,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    Text(
                      "Stranger Things",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    Row(
                      children: [
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
          })),
    );
  }
}
