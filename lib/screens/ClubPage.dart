import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBgColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Club Page',
                          style: TextStyle(
                              color: kBlackLessDark,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(FontAwesomeIcons.timesCircle,
                            color: kBlackLessDark, size: 40),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Image(
                    image: AssetImage('assets/png/2.jpg'),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.width - 30),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(height: 50, width: 5, color: kBlackLessDark),
                    SizedBox(width: 20),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'XYZ club' + '\n',
                            style: TextStyle(
                                color: kBlackLessDark,
                                fontSize: 28,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: 'Sindri college',
                            style: TextStyle(
                                color: kBlackLessDark,
                                fontSize: 24,
                                fontWeight: FontWeight.w600))
                      ]),
                    )
                  ],
                ),
                TitlesText(
                    title: 'About', titleDescription: 'Some description'),
                TitlesText(title: 'Motives', titleDescription: 'Some Motives')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitlesText extends StatelessWidget {
  final String title;
  final String titleDescription;
  TitlesText({@required this.title, @required this.titleDescription});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  color: kBlackLessDark,
                  fontWeight: FontWeight.w800,
                  fontSize: 24)),
          Text(titleDescription,
              style: TextStyle(color: kBlackLessDark, fontSize: 18))
        ],
      ),
    );
  }
}
