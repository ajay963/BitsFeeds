import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService extends ChangeNotifier {
  addFeed(
      {@required String imageUrl,
      @required String userEmail,
      @required String userName,
      @required String userProfilePicUrl,
      @required DateTime dateTime,
      @required String description}) async {
    CollectionReference feedsCollection =
        FirebaseFirestore.instance.collection('feeds');
    Map<String, dynamic> feedData = {
      "userName": userName,
      "userProfilePic": userProfilePicUrl,
      "userEmail": userEmail,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "description": description,
    };
    await _addFeedToClub(
        imageUrl: imageUrl,
        userEmail: userEmail,
        userName: userName,
        userProfilePicUrl: userProfilePicUrl,
        dateTime: dateTime,
        description: description);
    await feedsCollection.add(feedData);
  }

  _addFeedToClub(
      {@required String imageUrl,
      @required String userEmail,
      @required String userName,
      @required String userProfilePicUrl,
      @required DateTime dateTime,
      @required String description}) async {
    CollectionReference feedsCollection = FirebaseFirestore.instance
        .collection('feedsCategories')
        .doc()
        .collection(userEmail);
    Map<String, dynamic> feedData = {
      "userName": userName,
      "userProfilePic": userProfilePicUrl,
      "userEmail": userEmail,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "description": description,
    };

    await feedsCollection.add(feedData);
  }

  addEvent(
      {@required String imageUrl,
      @required String userEmail,
      @required String userName,
      @required String instituteName,
      @required String eventName,
      @required String userProfilePicUrl,
      @required DateTime dateTime,
      @required String eventDetails,
      @required String eventRules,
      @required String judgementCriteria}) async {
    CollectionReference feedsCollection =
        FirebaseFirestore.instance.collection('events');
    Map<String, dynamic> eventData = {
      "userName": userName,
      "userProfilePic": userProfilePicUrl,
      "userEmail": userEmail,
      "instituteName": instituteName,
      "eventName": eventName,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "eventDetails": eventDetails,
      "eventRules": eventRules,
      "judgementCriteria": judgementCriteria
    };
    await _addEventToClub(
        imageUrl: imageUrl,
        userEmail: userEmail,
        userName: userName,
        instituteName: instituteName,
        eventName: eventName,
        userProfilePicUrl: userProfilePicUrl,
        dateTime: dateTime,
        eventDetails: eventDetails,
        eventRules: eventRules,
        judgementCriteria: judgementCriteria);
    await feedsCollection.add(eventData);
  }

  _addEventToClub(
      {@required String imageUrl,
      @required String userEmail,
      @required String userName,
      @required String instituteName,
      @required String eventName,
      @required String userProfilePicUrl,
      @required DateTime dateTime,
      @required String eventDetails,
      @required String eventRules,
      @required String judgementCriteria}) async {
    CollectionReference feedsCollection = FirebaseFirestore.instance
        .collection('eventsCategories')
        .doc()
        .collection(userEmail);
    Map<String, dynamic> eventData = {
      "userName": userName,
      "userProfilePic": userProfilePicUrl,
      "userEmail": userEmail,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "eventDetails": eventDetails,
      "eventRules": eventRules,
      "judgementCriteria": judgementCriteria
    };

    await feedsCollection.add(eventData);
  }

  clubData(
      {@required String clubName,
      @required String about,
      @required String email,
      @required String motives,
      @required String imageUrl,
      @required String instituteName,
      @required String userId}) async {
    CollectionReference clubsCollection = FirebaseFirestore.instance
        .collection('club')
        .doc(instituteName)
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

  Future<Stream<List<String>>> getListOfUserIdFromFeeds(
      {@required docID}) async {
    CollectionReference feedsCollection =
        FirebaseFirestore.instance.collection('feeds');
    return feedsCollection.doc(docID).snapshots().map((userIdLists) {
      if (!userIdLists.exists) {
        return [];
      }
      return userIdLists.data()['userIdList'] as List<String>;
    });
  }

  Future<bool> likeFunction(
      {@required String postID, @required String userId}) async {
    bool _isLiked = false;
    List<String> listOfUser = [];
    CollectionReference postRefrence =
        FirebaseFirestore.instance.collection('feeds');
    Future<DocumentSnapshot> docSnapshot =
        FirebaseFirestore.instance.collection('feeds').doc(postID).get();

    DocumentSnapshot doc = await docSnapshot;
    listOfUser = doc.data()['ListOfUsers'] as List<String>;
    if (listOfUser.contains(userId)) {
      _isLiked = false;

      listOfUser.remove(userId);
      await postRefrence.doc(postID).update({'listOfUser': listOfUser});
    } else {
      _isLiked = true;
      listOfUser.add(userId);
      await postRefrence.doc(postID).update({'listOfUser': listOfUser});
    }
    return _isLiked;
  }
}
