import 'package:bits_news/Provider/eventNav.dart';
import 'package:bits_news/widgets/eventNavWidget.dart';
import 'package:flutter/material.dart';
import 'package:bits_news/component/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventMainPage extends StatelessWidget {
  //remember user name is used as clubName
  final String imageUrl;
  final String userEmail;
  final String userName;
  final String instituteName;
  final String eventName;
  final String userProfilePicUrl;
  final DateTime dateTime;
  final String eventDetails;
  final String eventRules;
  final String judgementCriteria;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  EventMainPage(
      {@required this.eventName,
      @required this.dateTime,
      @required this.imageUrl,
      @required this.instituteName,
      @required this.eventDetails,
      @required this.eventRules,
      @required this.judgementCriteria,
      @required this.userEmail,
      @required this.userName,
      @required this.userProfilePicUrl});
  @override
  Widget build(BuildContext context) {
    final eventPage = Provider.of<EventNav>(context);
    return Scaffold(
      backgroundColor: kWhiteBgColor,
      body: Stack(children: [
        SafeArea(
          child: PageView(
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              eventPage.setEventPAge(setPageNo: index);
            },
            children: <Widget>[
              //remember user name is used as clubName
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: EventDetails(
                    eventName: eventName,
                    eventDetails: eventDetails,
                    imageUrl: imageUrl,
                    instituteName: instituteName,
                    clubName: userName),
              ),
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child:
                      EventRules(eventName: eventName, eventRules: eventRules)),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: EventJudgement(
                    eventName: eventName, judgementCriteria: judgementCriteria),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: EventNavWidget(),
        )
      ]),
    );
  }
}

class EventDetails extends StatelessWidget {
  final String imageUrl;
  final String eventName;
  final String clubName;
  final String instituteName;
  final String eventDetails;
  EventDetails(
      {@required this.eventName,
      @required this.eventDetails,
      @required this.imageUrl,
      @required this.instituteName,
      @required this.clubName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Image(
              image: NetworkImage(imageUrl),
              height: MediaQuery.of(context).size.width - 100,
              width: MediaQuery.of(context).size.width - 50,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              eventName,
              style: TextStyle(
                  fontFamily: GoogleFonts.itim().fontFamily,
                  color: kBlackLessDark,
                  fontSize: 32),
            ),
          ),
          SizedBox(height: 20),
          RichText(
              text:
                  TextSpan(style: TextStyle(color: kBlackLessDark), children: [
            TextSpan(
                text: 'Organiser : ',
                style: TextStyle(
                    fontFamily: GoogleFonts.itim().fontFamily, fontSize: 32)),
            TextSpan(
                text: clubName,
                style: TextStyle(
                    fontFamily: GoogleFonts.delius().fontFamily, fontSize: 20)),
          ])),
          RichText(
              text:
                  TextSpan(style: TextStyle(color: kBlackLessDark), children: [
            TextSpan(
                text: 'Organiser :ooooo ',
                style: TextStyle(
                    fontFamily: GoogleFonts.delius().fontFamily,
                    fontSize: 20,
                    color: Colors.transparent)),
            TextSpan(
                text: instituteName,
                style: TextStyle(
                    fontFamily: GoogleFonts.delius().fontFamily, fontSize: 20)),
          ])),
          SizedBox(height: 20),
          EventTextCard(
            title: 'Event Details',
            titleData: eventDetails,
            nextLine: false,
          )
        ],
      ),
    );
  }
}

class EventRules extends StatelessWidget {
  final String eventName;
  final String eventRules;
  EventRules({@required this.eventName, @required this.eventRules});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 60),
          Center(
              child: Text(eventName,
                  style: TextStyle(
                    fontFamily: GoogleFonts.itim().fontFamily,
                    color: kBlackLessDark,
                    fontSize: 28,
                  ))),
          SizedBox(height: 20),
          EventTextCard(
              title: 'Event Rules', titleData: eventRules, nextLine: false)
        ],
      ),
    );
  }
}

class EventJudgement extends StatelessWidget {
  final String eventName;
  final String judgementCriteria;
  EventJudgement({@required this.eventName, @required this.judgementCriteria});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Center(
              child: Text(eventName,
                  style: TextStyle(
                    fontFamily: GoogleFonts.itim().fontFamily,
                    color: kBlackLessDark,
                    fontSize: 28,
                  ))),
          SizedBox(height: 20),
          EventTextCard(
              title: 'Judgement Criteria',
              titleData: judgementCriteria,
              nextLine: true)
        ],
      ),
    );
  }
}

class EventTextCard extends StatelessWidget {
  final String title;
  final String titleData;
  final bool nextLine;
  EventTextCard(
      {@required this.title,
      @required this.titleData,
      @required this.nextLine});
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(style: TextStyle(color: kBlackLessDark), children: [
      TextSpan(
          text: (nextLine) ? title + ' :\n' : title + ' : ',
          style: TextStyle(
              fontFamily: GoogleFonts.itim().fontFamily, fontSize: 32)),
      TextSpan(
          text: titleData,
          style: TextStyle(
              fontFamily: GoogleFonts.delius().fontFamily, fontSize: 20))
    ]));
  }
}
