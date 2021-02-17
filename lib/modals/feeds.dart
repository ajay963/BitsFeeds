import 'package:flutter/cupertino.dart';

class Feeds {
  String imageUrl;
  String userName;
  String userProfilePic;
  DateTime dateTime;
  String description;

  Feeds(
      {@required this.userName,
      @required this.userProfilePic,
      @required this.dateTime,
      @required this.imageUrl,
      @required this.description});

  factory Feeds.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String imageUrl = data['imageUrl'];
    String userName = data['username'];
    String userProfilePic = data['userProfile'];
    DateTime dateTime = data['dateTime'];
    String description = data['description'];

    return Feeds(
        userName: userName,
        userProfilePic: userProfilePic,
        dateTime: dateTime,
        imageUrl: imageUrl,
        description: description);
  }
  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "userProfilePic": userProfilePic,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "description": description,
    };
  }
}
