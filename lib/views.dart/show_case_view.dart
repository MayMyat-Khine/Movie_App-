import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_ui/data.vos/vos/movie_vo.dart';
import 'package:movie_app_ui/constants.dart/api_constants.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/views.dart/banner_view.dart';
import 'package:movie_app_ui/widgets/play_button_view.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  final MovieVO? movie;
  ShowCaseView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(children: [
        Positioned.fill(
          child: Text("data"),
          // child: Image.network("$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
          //     fit: BoxFit.cover)
        ),
        const Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie?.title ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: MARGIN_MEDIUM,
                  ),
                  TitleText("15 December 2016")
                ]),
          ),
        )
      ]),
    );
  }
}
