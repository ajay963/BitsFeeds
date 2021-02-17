import 'dart:ui';

import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double topPadding;
  final double leftPadding;
  final double rightPadding;
  final double bottomPadding;
  final double width;
  final double borderRadius;
  GlassCard(
      {@required this.child,
      this.width,
      this.borderRadius = 10,
      this.topPadding = 20,
      this.bottomPadding = 20,
      this.leftPadding = 20,
      this.rightPadding = 20});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
              color: kBlackDark.withOpacity(0.4),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Container(
            padding: EdgeInsets.only(
                top: topPadding,
                left: leftPadding,
                bottom: bottomPadding,
                right: rightPadding),
            child: child,
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.lighten,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.05)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
        ),
      ),
    );
  }
}

class GlassFeeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.width + 190,
          width: MediaQuery.of(context).size.width - 40,
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage('assets/png/2.jpg'),
                  height: MediaQuery.of(context).size.width - 20,
                  width: MediaQuery.of(context).size.width - 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              FeedsTextCard(),
            ],
          ),
          decoration: BoxDecoration(
              //  backgroundBlendMode: BlendMode.lighten,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1)
              ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        ),
      ),
    );
  }
}

class FeedsTextCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 60,
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('assets/png/face1.jpeg'),
                    radius: 22),
                SizedBox(width: 10),
                Expanded(
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Name\n',
                            style: TextStyle(
                                fontSize: 20,
                                color: kGreyDark,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'DateAndTime',
                            style: TextStyle(fontSize: 18, color: kGreyDark)),
                      ])),
                )
              ],
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Some Random Text to display in the cards' +
                              '$contribute' +
                              '$contribute',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: kGreylight)),
                      Text('Tap to Read More..',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kGreylight))
                    ]),
              ),
            )
          ]),
    );
  }
}

class FlatGlassButton extends StatelessWidget {
  final Widget child;
  final Function ontap;
  FlatGlassButton({@required this.ontap, this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            color: Colors.white.withOpacity(0.3),
          ),
          child: child),
    );
  }
}

class FlatGradientButton extends StatelessWidget {
  final Widget child;
  final Function ontap;
  final double width;
  FlatGradientButton({@required this.ontap, this.child, this.width});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          //splashColor: kPkThemeShade1,
          onTap: ontap,
          child: Ink(
            child: child,
            width: (width == null)
                ? MediaQuery.of(context).size.width * 0.5
                : width,
            padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 0),
            decoration: BoxDecoration(
              gradient: kThemeGradient,
            ),
          ),
        ),
      ),
    );
  }
}
