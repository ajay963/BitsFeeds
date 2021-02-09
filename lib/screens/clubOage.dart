import 'package:bits_news/component/constants.dart';
import 'package:bits_news/customPainter/curvePath.dart';
import 'package:flutter/material.dart';

class ClubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image(
            image: AssetImage('assets/png/2.jpg'),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width - 180),
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width *
                      0.5), //You can Replace this with your desired WIDTH and HEIGHT
              painter: CustomPainterClubCurve(),
            ),
          ),
          ClubInfo()
        ],
      ),
    );
  }
}

class ClubInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width + 40, left: 20),
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Club Name\n',
              style: TextStyle(
                  color: kBlackDark,
                  fontSize: 36,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'Institute Name\n\n\n\n',
              style: TextStyle(
                  color: kBlackDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'About\n\n',
              style: TextStyle(
                  color: kBlackLessDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'About the club in Breif\n\n\n\n\n',
              style: TextStyle(color: kBlackDark, fontSize: 16)),
          TextSpan(
              text: 'Motive\n\n',
              style: TextStyle(
                  color: kBlackDark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'Motive in Details\n',
              style: TextStyle(color: kBlackLessDark, fontSize: 16))
        ])));
  }
}
