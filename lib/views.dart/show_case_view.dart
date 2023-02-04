import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/views.dart/banner_view.dart';
import 'package:movie_app_ui/widgets/play_button_view.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(children: [
        Positioned.fill(
            child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGEaNeD1QdMG1bclIop7bMvBbxgIrsWutMxQ&usqp=CAU",
                fit: BoxFit.cover)),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM_2),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Passengers",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
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
