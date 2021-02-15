import 'package:bits_news/component/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubPass extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User userData = firebaseAuth.currentUser;
    final CollectionReference clubData = FirebaseFirestore.instance
        .collection('club')
        .doc(userData.uid)
        .collection(userData.email);
    return StreamBuilder(
        stream: clubData.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Material(child: Center(child: Text("Loading")));
          else if (snapshot.hasData)
            return ClubPage(
              clubName: snapshot.data.docs[0].data()['clubName'],
              imageUrl: snapshot.data.docs[0].data()['imageUrl'],
              instituteName: snapshot.data.docs[0].data()['instituteName'],
              about: snapshot.data.docs[0].data()['about'],
              motive: snapshot.data.docs[0].data()['motive'],
            );
          return Material(child: Center(child: Text('Something went wrong')));
        });
  }
}

class ClubPage extends StatelessWidget {
  final String clubName;
  final String about;
  final String motive;
  final String instituteName;

  final String imageUrl;
  ClubPage(
      {@required this.clubName,
      @required this.imageUrl,
      @required this.instituteName,
      @required this.about,
      @required this.motive});
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
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Club Page',
                          style: TextStyle(
                              // fontFamily: GoogleFonts.delius().fontFamily,
                              color: kBlackLessDark,
                              fontSize: 38,
                              fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(FontAwesomeIcons.timesCircle,
                            color: kBlackLessDark, size: 40),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Container(
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl), radius: 90),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: kGreyDark,
                              offset: Offset(0, 0),
                              blurRadius: 12)
                        ]),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                            color: kBlackLessDark,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.itim().fontFamily),
                        children: [
                          TextSpan(
                              text: clubName + '\n',
                              style: TextStyle(
                                fontSize: 28,
                              )),
                          TextSpan(
                              text: instituteName,
                              style: TextStyle(
                                fontSize: 24,
                              ))
                        ]),
                  ),
                ),
                SizedBox(height: 40),
                TitlesText(title: 'About', titleDescription: about),
                TitlesText(title: 'Motives', titleDescription: motive)
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
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: kBlackLessDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 28)),
          SizedBox(height: 5),
          Text(titleDescription,
              style: TextStyle(
                  fontFamily: GoogleFonts.delius().fontFamily,
                  color: kBlackLessDark,
                  fontSize: 20))
        ],
      ),
    );
  }
}
