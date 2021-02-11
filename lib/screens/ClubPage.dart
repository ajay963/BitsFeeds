import 'package:bits_news/component/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                      Text('About',
                          style: TextStyle(
                              color: kBlackLessDark,
                              fontSize: 36,
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
                Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.width - 30,
                    padding: EdgeInsets.all(14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.width - 30),
                    ),
                    decoration: BoxDecoration(
                        color: kWhiteBgColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: kGreyDark.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 10,
                              offset: Offset(0, 0))
                        ])),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(height: 55, width: 5, color: kBlackLessDark),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: clubName + '\n',
                            style: TextStyle(
                                color: kBlackLessDark,
                                fontSize: 28,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: instituteName,
                            style: TextStyle(
                                color: kBlackLessDark,
                                fontSize: 24,
                                fontWeight: FontWeight.w600))
                      ]),
                    )
                  ],
                ),
                TitlesText(title: 'About', titleDescription: about),
                // Divider(
                //   color: kGreyDark.withOpacity(0.5),
                //   thickness: 2,
                // ),
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
      margin: EdgeInsets.symmetric(vertical: 15),
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
              style: TextStyle(color: kBlackLessDark, fontSize: 20))
        ],
      ),
    );
  }
}
