import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/widgets/gradient_view.dart';
import 'package:movie_app_ui/widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Positioned.fill(child: BannerImageView()),
        Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(),
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
  const BannerTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stranger Things",
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
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGEaNeD1QdMG1bclIop7bMvBbxgIrsWutMxQ&usqp=CAU",
        fit: BoxFit.cover);
  }
}
