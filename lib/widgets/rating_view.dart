import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_ui/resources/dimens.dart';

class RatingView extends StatelessWidget {
  const RatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: 5.0,
        itemBuilder: ((context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            )),
        itemSize: MARGIN_MEDIUM_2,
        onRatingUpdate: (rating) {
          print(rating);
        });
  }
}
