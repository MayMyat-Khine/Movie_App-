import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_app_ui/resources/colors.dart';
import 'package:movie_app_ui/resources/dimens.dart';
import 'package:movie_app_ui/widgets/gradient_view.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(slivers: [MovieDetailsSliverAppBarView()]),
      ),
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  const MovieDetailsSliverAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
        children: [
          Positioned.fill(
            child: MovieDetailsAppBarImageView(),
          ),
          Positioned.fill(child: GradientView()),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
              child: BackButtonView(),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
                child: Icon(Icons.search),
              ))
        ],
      )),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  const MovieDetailsAppBarImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3_M8A2WLy8BR2DSRAaEq7gncMX2Jm8AyPwA&usqp=CAU",
      fit: BoxFit.cover,
    );
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MARGIN_XXLARGE,
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
      child: Icon(
        Icons.chevron_left,
        color: Colors.white,
        size: MARGIN_XLARGE,
      ),
    );
  }
}
