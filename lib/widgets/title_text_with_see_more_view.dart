import 'package:flutter/material.dart';
import 'package:movie_app_ui/widgets/see_more_text.dart';
import 'package:movie_app_ui/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  TitleTextWithSeeMoreView(this.title, this.text,
      {this.seeMoreButtonVisibility = true});
  final String title, text;
  final bool seeMoreButtonVisibility;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(title),
        Spacer(),
        Visibility(visible: seeMoreButtonVisibility, child: SeeMoreText(text))
      ],
    );
  }
}
