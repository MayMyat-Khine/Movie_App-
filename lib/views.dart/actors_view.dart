import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';

class ActorsView extends StatelessWidget {
  const ActorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: MOVIE_LIST_IIEM_WIDTH,
        child: Stack(children: [
          Positioned.fill(
              child: ActorImageView()),
          Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(),
          )
        ]),
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3_M8A2WLy8BR2DSRAaEq7gncMX2Jm8AyPwA&usqp=CAU",
        fit: BoxFit.cover);
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_outline_outlined,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  const ActorNameAndLikeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM_2),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Finn Wolfhard",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: Colors.amber,
                  size: MARGIN_CARD_MEDIUM_2,
                ),
                Text(
                  "You Liked 13 movies",
                  style: TextStyle(
                      color: HOME_SCREEN_LIST_TITLE_COLOR,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ]),
    );
  }
}
