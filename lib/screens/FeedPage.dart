import 'dart:ui';
import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          color: kPkThemeShade1,
          axisDirection: AxisDirection.down,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Discover\n',
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w400,
                                color: kPkThemeShade1)),
                        TextSpan(
                            text: 'Get youself updated',
                            style: TextStyle(
                                fontSize: 20,
                                color: kBlackLessDark,
                                fontWeight: FontWeight.bold))
                      ]),
                    )),
                SizedBox(height: 20),
                FeedsCard(
                    name: 'Ajay', imageUrl: '2.jpg', date: DateTime.now()),
                FeedsCard(
                    name: 'Ajay', imageUrl: '2.jpg', date: DateTime.now()),
                FeedsCard(
                    name: 'Ajay', imageUrl: '2.jpg', date: DateTime.now()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedsCard extends StatelessWidget {
  final DateTime date;
  final String name;
  final String imageUrl;

  FeedsCard({
    @required this.name,
    @required this.imageUrl,
    @required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 560,
      width: MediaQuery.of(context).size.width - 50,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      padding: EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: AssetImage('assets/png/2.jpg'),
                height: MediaQuery.of(context).size.width - 80,
                width: MediaQuery.of(context).size.width - 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          FeedsTextCard(
            name: name,
            imageUrl: imageUrl,
            date: date,
          ),
          SizedBox(height: 20),
        ],
      ),
      decoration: BoxDecoration(
          color: kWhiteBgColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: kBlackDark.withOpacity(0.14),
                offset: Offset(0, 0),
                blurRadius: 16)
          ]),
    );
  }
}

class FeedsTextCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final DateTime date;
  FeedsTextCard(
      {@required this.name, @required this.imageUrl, @required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 80,
      margin: EdgeInsets.only(left: 15),
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/png/face1.jpeg'),
                  radius: 22,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: (name.isEmpty) ? 'Name\n' : name + '\n',
                            style: TextStyle(
                                fontSize: 20,
                                color: kBlackLessDark,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: DateFormat.yMMMd().format(date).toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: kBlackLessDark,
                                fontWeight: FontWeight.w600)),
                      ])),
                )
              ],
            ),
          ]),
    );
  }
}
