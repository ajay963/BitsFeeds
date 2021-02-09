import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService extends ChangeNotifier {
  User userId;
  addFeed(String imageUrl, String userName, String userProfilePic,
      DateTime dateTime, String description) async {
    CollectionReference feedsCollection =
        FirebaseFirestore.instance.collection('feeds');
    Map<String, dynamic> feedData = {
      "userName": userName,
      "userProfilePic": userProfilePic,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "description": description,
    };

    await feedsCollection.add(feedData);
  }

  clubData(
      {String clubName,
      String about,
      String email,
      String motives,
      @required String imageUrl,
      String instituteName,
      String userId}) async {
    CollectionReference clubsCollection = FirebaseFirestore.instance
        .collection('club')
        .doc(userId)
        .collection(email);
    Map<String, dynamic> clubData = {
      'clubName': clubName,
      'instituteName': instituteName,
      'about': about,
      'motive': motives,
      'imageUrl': imageUrl,
      'email': email
    };
    await clubsCollection.add(clubData);
  }
}
