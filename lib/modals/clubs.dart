import 'package:meta/meta.dart';

class Clubs {
  String clubName;
  String instituteName;
  String about;
  String motives;
  String imageUrl;
  String email;

  Clubs(
      {@required this.clubName,
      @required this.about,
      @required this.email,
      @required this.motives,
      @required this.imageUrl,
      @required this.instituteName});

  factory Clubs.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    String clubName = data['task'];
    String instituteName = data['extraNote'];
    String about = data['complete'];
    String motives = data['motives'];
    String imageUrl = data['imageUrl'];
    String email = data['email'];

    return Clubs(
        clubName: clubName,
        about: about,
        email: email,
        motives: motives,
        imageUrl: imageUrl,
        instituteName: instituteName);
  }

  Map<String, dynamic> toMap() {
    return {
      'clubName': clubName,
      'instituteName': instituteName,
      'about': about,
      'motive': motives,
      'imageUrl': imageUrl,
      'email': email
    };
  }
}
