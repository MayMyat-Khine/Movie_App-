import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/network/api_constants.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/widgets/gradient_view.dart';
import 'package:movie_app_ui/widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final MovieVO? movie;
  BannerView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Positioned.fill(
            child: BannerImageView(
          bannerImageUrl: movie?.posterPath ?? "",
        )),
        Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(
            title: movie?.title ?? "",
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        )
      ]),
    );
  }
}

class BannerTitleView extends StatelessWidget {
  final String title;
  BannerTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Official Review",
              style: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )
          ]),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String bannerImageUrl;
  BannerImageView({required this.bannerImageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network("$IMAGE_BASE_URL$bannerImageUrl", fit: BoxFit.cover);
  }
}
