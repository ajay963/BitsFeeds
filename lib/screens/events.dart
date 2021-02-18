import 'package:bits_news/component/constants.dart';
import 'package:bits_news/screens/eventPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return SafeArea(
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        fontFamily: GoogleFonts.itim().fontFamily,
                      ),
                      children: [
                        TextSpan(
                            text: 'Events\n',
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w400,
                                color: kPkThemeShade1)),
                        TextSpan(
                            text: 'Track all the events',
                            style: TextStyle(
                                fontSize: 20,
                                color: kBlackLessDark,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              ),
              SizedBox(height: 20),
              EventInfoCard(eventName: 'kho-kho', date: DateTime.now())
            ],
          )),
    );
  }
}

class EventInfoCard extends StatelessWidget {
  final String eventName;
  final DateTime date;
  EventInfoCard({@required this.eventName, @required this.date});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => EventMainPage())),
      child: Container(
        margin: EdgeInsets.only(left: 30),
        height: 120,
        width: MediaQuery.of(context).size.width - 70,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                height: 120,
                width: MediaQuery.of(context).size.width - 70,
                image: AssetImage('assets/png/2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: kWhiteBgColor),
                          children: [
                        TextSpan(
                            text: DateFormat.yMMMd().format(date) + '\n',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.delius().fontFamily)),
                        TextSpan(
                            text: DateFormat.EEEE().format(date).toString() +
                                '\n\n',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.delius().fontFamily)),
                        TextSpan(
                          text: eventName,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: GoogleFonts.itim().fontFamily),
                        )
                      ])),
                  Icon(
                    FontAwesomeIcons.angleRight,
                    color: kWhiteBgColor,
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: kBlackDark.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}
