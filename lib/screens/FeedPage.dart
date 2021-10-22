import 'dart:ui';
import 'package:bits_news/component/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    // final firestore = Provider.of<FirestoreService>(context);
    final CollectionReference firestorFeedsData =
        FirebaseFirestore.instance.collection('feeds');

    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: (user.displayName == null)
                            ? 'Discover\n'
                            : 'Hi ' + user.displayName + '\n',
                        style: Theme.of(context).textTheme.headline1),
                    TextSpan(
                        text: 'Get youself updated',
                        style: Theme.of(context).textTheme.headline2)
                  ]),
                )),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
                stream: firestorFeedsData.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FeedsCard(
                          docID: snapshot.data.docs[index].id,
                          name: snapshot.data.docs[index].data()['userName'],
                          imageUrl:
                              snapshot.data.docs[index].data()['imageUrl'],
                          date: snapshot.data.docs[index].data()['dateTime'],
                          description:
                              snapshot.data.docs[index].data()['description'],
                          userImageUrl: snapshot.data.docs[index]
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
          ],
        ),
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
  final String docID;
  final double borderRadius = 10;

  FeedsCard(
      {@required this.name,
      @required this.imageUrl,
      @required this.date,
      @required this.description,
      @required this.docID,
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
          SizedBox(height: 10),
          LikeAndShare(likes: 144),
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
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Read More',
              style: TextStyle(
                color: kPkThemeShade1,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, 10),
                blurRadius: 20)
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
                            style: Theme.of(context).textTheme.bodyText2),
                        TextSpan(
                            text: DateFormat.yMMMd()
                                .format(date.toDate())
                                .toString(),
                            style: Theme.of(context).textTheme.bodyText2),
                      ])),
                )
              ],
            ),
          ]),
    );
  }
}

class LikeAndShare extends StatelessWidget {
  final int likes;
  LikeAndShare({@required this.likes});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Icon(
          FontAwesomeIcons.solidHeart,
          size: 34,
          color: kPkThemeShade1,
        ),
        SizedBox(width: 10),
        Text(
          '$likes Likes',
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1.color,
              fontSize: 20,
              fontFamily: Theme.of(context).textTheme.headline1.fontFamily),
        ),
        SizedBox(width: 30),
        Icon(FontAwesomeIcons.telegramPlane,
            size: 34, color: Theme.of(context).iconTheme.color),
        SizedBox(width: 10),
        Text(
          'Share',
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1.color,
              fontSize: 20,
              fontFamily: Theme.of(context).textTheme.headline1.fontFamily),
        )
      ],
    );
  }
}
