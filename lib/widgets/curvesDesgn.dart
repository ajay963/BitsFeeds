import 'package:bits_news/customPainter/curvePath.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CurvesDesign extends StatelessWidget {
  final Widget child;
  CurvesDesign({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: FlareActor(
              "assets/curveDesign/curveDesign.flr",
              artboard: "para",
              animation: "active",
              fit: BoxFit.cover,
            )),
        ParasuitAnimation(),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width),
          child: child,
        )
      ],
    );
  }
}

class ParasuitAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width - 200),
          child: CustomPaint(
            size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.width *
                    0.625), //You can Replace this with your desired WIDTH and HEIGHT
            painter: CustomPainterConvexCurve(),
          ),
        ),
      ],
    );
  }
}
