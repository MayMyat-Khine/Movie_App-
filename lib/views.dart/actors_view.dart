import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_ui/data.vos/vos/actor_vo.dart';
import 'package:movie_app_ui/network/api_constants.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';

class ActorsView extends StatelessWidget {
  final ActorVO? actor;
  ActorsView({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MOVIE_LIST_IIEM_WIDTH,
        child: Stack(children: [
          Positioned.fill(
              child: ActorImageView(imageUrl: actor?.profilePath ?? "")),
          const Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(
              name: actor?.name,
            ),
          )
        ]),
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String imageUrl;
  ActorImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network("$IMAGE_BASE_URL$imageUrl", fit: BoxFit.cover);
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_outline_outlined,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String? name;
  ActorNameAndLikeView({this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM_2),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Row(
              children: [
                const Icon(
                  Icons.thumb_up,
                  color: Colors.amber,
                  size: MARGIN_CARD_MEDIUM_2,
                ),
                const Text(
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
