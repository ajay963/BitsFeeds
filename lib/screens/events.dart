import 'package:bits_news/component/constants.dart';
import 'package:bits_news/screens/eventPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventPage extends StatelessWidget {
  final CollectionReference firestorEventsData =
      FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 30),
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: firestorEventsData.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return EventInfoCard(
                          eventName:
                              snapshot.data.docs[index].data()['eventName'],
                          dateTime:
                              snapshot.data.docs[index].data()['dateTime'],
                          imageUrl:
                              snapshot.data.docs[index].data()['imageUrl'],
                          instituteName:
                              snapshot.data.docs[index].data()['instituteName'],
                          eventDetails:
                              snapshot.data.docs[index].data()['eventDetails'],
                          eventRules:
                              snapshot.data.docs[index].data()['eventRules'],
                          judgementCriteria: snapshot.data.docs[index]
                              .data()['judgementCriteria'],
                          userEmail:
                              snapshot.data.docs[index].data()['userEmail'],
                          userName:
                              snapshot.data.docs[index].data()['userName'],
                          userProfilePicUrl: snapshot.data.docs[index]
                              .data()['userProfilePic'],
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading"));
                  }
                  return Center(child: Text('Something went wrong'));
                }),
          ),
        ],
      ),
    );
  }
}

class EventInfoCard extends StatelessWidget {
  final String imageUrl;
  final String userEmail;
  final String userName;
  final String instituteName;
  final String eventName;
  final String userProfilePicUrl;
  final Timestamp dateTime;
  final String eventDetails;
  final String eventRules;
  final String judgementCriteria;
  EventInfoCard(
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
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventMainPage(
                    eventName: eventName,
                    dateTime: dateTime.toDate(),
                    imageUrl: imageUrl,
                    instituteName: instituteName,
                    eventDetails: eventDetails,
                    eventRules: eventRules,
                    judgementCriteria: judgementCriteria,
                    userName: userName,
                    userEmail: userEmail,
                    userProfilePicUrl: userProfilePicUrl,
                  ))),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 30),
        height: 120,
        width: MediaQuery.of(context).size.width - 70,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                height: 120,
                width: MediaQuery.of(context).size.width - 50,
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
                            text: DateFormat.yMMMd().format(dateTime.toDate()) +
                                '\n',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.delius().fontFamily)),
                        TextSpan(
                            text: DateFormat.EEEE()
                                    .format(dateTime.toDate())
                                    .toString() +
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
