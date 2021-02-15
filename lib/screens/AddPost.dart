import 'dart:io';
import 'package:bits_news/component/constants.dart';
import 'package:bits_news/screens/LoadingPage.dart';
import 'package:bits_news/screens/signUp.dart';
import 'package:bits_news/services/cloudServices.dart';
import 'package:bits_news/services/firestoreService.dart';
import 'package:bits_news/widgets/glassMorphism.dart';
import 'package:bits_news/widgets/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPostMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cloudStorage = Provider.of<CloudStorageService>(context);

    return Stack(
      children: [
        AddPost(),
        (cloudStorage.isUploading == true)
            ? UploadFileAnimation(
                child: Text(
                  'Uploading ${cloudStorage.dataTransferSize}KB out of ${cloudStorage.totalDataSize}KB',
                  style: TextStyle(color: kWhiteBgColor, fontSize: 20),
                ),
              )
            : SizedBox()
      ],
    );
  }
}

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File _imageFile;
  final picker = ImagePicker();
  final DateTime date = DateTime.now();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    // _imageFile.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User userData = firebaseAuth.currentUser;
    final fireStore = Provider.of<FirestoreService>(context);
    final cloudStorage = Provider.of<CloudStorageService>(context);

    print('data from snapshot ${userData.email}');
    print('data from snapshot ${userData.uid}');

    addPostData(
        {String imageUrl,
        String userEmail,
        String userName,
        String userProfilePicUrl,
        DateTime dateTime,
        String description}) async {
      await fireStore.addFeed(
          imageUrl: imageUrl,
          userEmail: userEmail,
          userName: userName,
          userProfilePicUrl: userProfilePicUrl,
          dateTime: dateTime,
          description: description);
      await cloudStorage.cloudServiceVariableReset();
      Navigator.pop(context);
    }

    //final User userData = Provider.of<FirestoreService>(context).getUser();
    final CollectionReference accountData = FirebaseFirestore.instance
        .collection('club')
        .doc(userData.uid)
        .collection(userData.email);
    return Scaffold(
      backgroundColor: kWhiteBgColor,
      body: StreamBuilder(
        stream: accountData.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Post',
                              style: TextStyle(
                                  fontSize: 36,
                                  color: kPkThemeShade1,
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(FontAwesomeIcons.timesCircle,
                                  color: kBlackLessDark, size: 40),
                            )
                          ]),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat.yMMMd().format(date).toString(),
                            style: TextStyle(
                                fontSize: 24,
                                color: kBlackLessDark,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: 20),
                      FeedsCard(
                          onAddPhotoButtonTrigrred: () => getImage(),
                          onUploadButtonTrigrred: () async {
                            if (_imageFile == null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => MssgDialog(
                                      title: 'Error',
                                      mssg: 'PLaese add photo',
                                      context: context));
                            } else if (await _imageFile.length() > 1024 * 700) {
                              showDialog(
                                  context: context,
                                  builder: (context) => MssgDialog(
                                      title: 'Size Exceed',
                                      mssg:
                                          'Please select a file less than 1 MB',
                                      context: context));
                            } else if (await _imageFile.exists()) {
                              print('upload starte');
                              await cloudStorage.feedsImageUpload(
                                  imageFileToUpload: _imageFile);
                              print('upload end');
                            }
                          },
                          onPostButtonTrigrred: () => addPostData(
                                userEmail: userData.email,
                                dateTime: DateTime.now(),
                                imageUrl: cloudStorage.imageUrl,
                                description: descriptionController.text,
                                userName:
                                    snapshot.data.docs[0].data()['clubName'],
                                userProfilePicUrl:
                                    snapshot.data.docs[0].data()['imageUrl'],
                              ),
                          postImageFile: _imageFile,
                          date: date,
                          name: snapshot.data.docs[0].data()['clubName'],
                          imageUrl: snapshot.data.docs[0].data()['imageUrl']),
                      SizedBox(height: 20),
                      (cloudStorage.isSucess == true)
                          ? BorderedColoredTextField(
                              fieldName: 'Tell Something',
                              color: kPkThemeShade1,
                              maxLines: 5,
                              controller: descriptionController,
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FeedsCard extends StatelessWidget {
  final DateTime date;
  final String name;
  final String imageUrl;
  final File postImageFile;
  final Function onUploadButtonTrigrred;
  final Function onAddPhotoButtonTrigrred;
  final Function onPostButtonTrigrred;

  FeedsCard(
      {@required this.name,
      @required this.imageUrl,
      @required this.postImageFile,
      @required this.date,
      this.onAddPhotoButtonTrigrred,
      this.onUploadButtonTrigrred,
      this.onPostButtonTrigrred});
  @override
  Widget build(BuildContext context) {
    final cloudStorage = Provider.of<CloudStorageService>(context);

    return Container(
      //  height: 560,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: (postImageFile == null)
                    ? AssetImage('assets/png/2.jpg')
                    : FileImage(postImageFile),
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
          ),
          SizedBox(height: 20),
          (cloudStorage.isSucess == false)
              ? Container(
                  margin: EdgeInsets.only(left: 15),
                  child: FlatGradientButton(
                    ontap: onAddPhotoButtonTrigrred,
                    width: 160,
                    child: Text(
                      'Add Photo',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kBlackLessDark,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : SizedBox(),
          (cloudStorage.isSucess == false)
              ? Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: FlatGradientButton(
                    ontap: onUploadButtonTrigrred,
                    width: 120,
                    child: Text(
                      'Upload',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kBlackLessDark,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : SizedBox(),
          (cloudStorage.isSucess == true)
              ? Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: FlatGradientButton(
                    ontap: onPostButtonTrigrred,
                    width: 120,
                    child: Text(
                      'Post',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kBlackLessDark,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      decoration: BoxDecoration(
          color: kWhiteBgColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: kGreyDark.withOpacity(0.6),
                offset: Offset(0, 0),
                blurRadius: 20)
          ]),
    );
  }
}

class FeedsTextCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final DateTime date;
  FeedsTextCard(
      {@required this.name, @required this.imageUrl, @required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 80,
      margin: EdgeInsets.only(left: 15),
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: (imageUrl.isEmpty)
                      ? AssetImage('assets/png/face1.jpeg')
                      : NetworkImage(imageUrl),
                  radius: 22,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style: TextStyle(
                            fontFamily: GoogleFonts.itim().fontFamily,
                          ),
                          children: [
                            TextSpan(
                                text: (name.isEmpty) ? 'Name\n' : name + '\n',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: kBlackLessDark,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    DateFormat.yMMMd().format(date).toString(),
                                style: TextStyle(
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
