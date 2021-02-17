import 'dart:ui';
import 'package:bits_news/component/constants.dart';
// import 'package:bits_news/services/firestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final firestore = Provider.of<FirestoreService>(context);
    final CollectionReference firestorFeedsData =
        FirebaseFirestore.instance.collection('feeds');

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 40),
          Container(
              margin: EdgeInsets.only(left: 30),
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                    children: [
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: firestorFeedsData.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading"));
                  }
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FeedsCard(
                        name: snapshot.data.docs[index].data()['userName'],
                        imageUrl: snapshot.data.docs[index].data()['imageUrl'],
                        date: snapshot.data.docs[index].data()['dateTime'],
                        description:
                            snapshot.data.docs[index].data()['description'],
                        userImageUrl:
                            snapshot.data.docs[index].data()['userProfilePic'],
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class FeedsCard extends StatelessWidget {
  final Timestamp date;
  final String name;
  final String imageUrl;
  final String userImageUrl;
  final String description;

  final double borderRadius = 5;

  FeedsCard(
      {@required this.name,
      @required this.imageUrl,
      @required this.date,
      @required this.description,
      @required this.userImageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 560,
      width: MediaQuery.of(context).size.width - 50,
      margin: EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
      padding: EdgeInsets.only(top: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image(
                image: NetworkImage(imageUrl),
                height: MediaQuery.of(context).size.width - 50,
                width: MediaQuery.of(context).size.width - 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          FeedsTextCard(
            name: name,
            imageUrl: imageUrl,
            date: date,
            userImageUrl: userImageUrl,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              description,
              maxLines: 3,
              style: TextStyle(
                  fontFamily: GoogleFonts.delius().fontFamily,
                  color: kBlackLessDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Read More',
              style: TextStyle(
                  color: kPkThemeShade1,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
      decoration: BoxDecoration(
          color: kWhiteBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
                color: kGreyDark.withOpacity(1),
                offset: Offset(0, 0),
                blurRadius: 12)
          ]),
    );
  }
}

class FeedsTextCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String userImageUrl;
  final Timestamp date;
  FeedsTextCard(
      {@required this.name,
      @required this.userImageUrl,
      @required this.imageUrl,
      @required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 80,
      // margin: EdgeInsets.only(left: 15),
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: NetworkImage(userImageUrl),
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
                                fontFamily: GoogleFonts.itim().fontFamily,
                                fontSize: 20,
                                color: kBlackLessDark,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: DateFormat.yMMMd()
                                .format(date.toDate())
                                .toString(),
                            style: TextStyle(
                                fontFamily: GoogleFonts.itim().fontFamily,
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
