import 'dart:io';
import 'package:bits_news/component/constants.dart';
import 'package:bits_news/component/theme.dart';
import 'package:bits_news/widgets/animations.dart';
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

class AddEventMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cloudStorage = Provider.of<CloudStorageService>(context);

    return Stack(
      children: [
        AddEvent(),
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

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _judgementController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();

  final _eventDetailsFormKey = GlobalKey<FormState>();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 20),
      // initialDatePickerMode: DatePickerMode.year,
      cancelText: 'Back',
      confirmText: 'Select',
      builder: (context, child) {
        return Theme(
          data: CustomTheme.calenderTheme(context),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File _imageFile;
  final picker = ImagePicker();
  DateTime selectedDate;

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
    _detailsController.dispose();
    _rulesController.dispose();
    _judgementController.dispose();

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

    addEventsData({
      @required String imageUrl,
      @required String userEmail,
      @required String userName,
      @required String userProfilePicUrl,
      @required DateTime dateTime,
      @required String instituteName,
      @required String eventName,
      @required String eventDetails,
      @required String eventRules,
      @required String judgementCriteria,
    }) async {
      await fireStore.addEvent(
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
                  child: Form(
                    key: _eventDetailsFormKey,
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
                                'Add Event',
                                style: TextStyle(
                                    fontSize: 36,
                                    color: kPkThemeShade1,
                                    fontWeight: FontWeight.w400),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await cloudStorage
                                      .cloudServiceVariableReset();

                                  Navigator.pop(context);
                                },
                                child: Icon(FontAwesomeIcons.timesCircle,
                                    color: kBlackLessDark, size: 40),
                              )
                            ]),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              (selectedDate == null)
                                  ? 'Select a date'
                                  : DateFormat.yMMMd()
                                      .format(selectedDate)
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: kBlackLessDark,
                                  fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: 20),
                        FeedsCard(
                          onSelectDateButtonTrigrred: () async =>
                              _selectDate(context),
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
                              await cloudStorage.eventsImageUpload(
                                  imageFileToUpload: _imageFile);
                            }
                          },
                          onPostButtonTrigrred: () {
                            if (_eventDetailsFormKey.currentState.validate()) {
                              (selectedDate != null)
                                  ? addEventsData(
                                      userEmail: userData.email,
                                      dateTime: selectedDate,
                                      imageUrl: cloudStorage.imageUrl,
                                      eventName:
                                          _eventNameController.text.trim(),
                                      userName: snapshot.data.docs[0]
                                          .data()['clubName'],
                                      userProfilePicUrl: snapshot.data.docs[0]
                                          .data()['imageUrl'],
                                      instituteName: snapshot.data.docs[0]
                                          .data()['instituteName'],
                                      eventDetails:
                                          _detailsController.text.trim(),
                                      eventRules: _rulesController.text.trim(),
                                      judgementCriteria:
                                          _judgementController.text.trim(),
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (context) => MssgDialog(
                                          title: 'Error',
                                          mssg: 'Please Select date',
                                          context: context));
                            }
                          },
                          postImageFile: _imageFile,
                          date: selectedDate,
                          name: snapshot.data.docs[0].data()['clubName'],
                          imageUrl: snapshot.data.docs[0].data()['imageUrl'],
                        ),
                        SizedBox(height: 20),
                        (cloudStorage.isSucess == true)
                            ? BorderedColoredTextField(
                                fieldName: 'Event Name',
                                color: kPkThemeShade1,
                                maxLines: 1,
                                controller: _eventNameController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Event Name is missing';
                                  else
                                    return null;
                                },
                              )
                            : SizedBox(),
                        (cloudStorage.isSucess == true)
                            ? BorderedColoredTextField(
                                fieldName: 'Event Details',
                                color: kPkThemeShade1,
                                maxLines: 5,
                                controller: _detailsController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Event Details is empty';
                                  else
                                    return null;
                                },
                              )
                            : SizedBox(),
                        (cloudStorage.isSucess == true)
                            ? BorderedColoredTextField(
                                fieldName: 'Rules',
                                color: kPkThemeShade1,
                                maxLines: 5,
                                controller: _rulesController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Rules is missing';
                                  else
                                    return null;
                                },
                              )
                            : SizedBox(),
                        (cloudStorage.isSucess == true)
                            ? BorderedColoredTextField(
                                fieldName: 'Judgement Criteria',
                                color: kPkThemeShade1,
                                maxLines: 5,
                                controller: _judgementController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Judgement criteria is missing';
                                  else
                                    return null;
                                },
                              )
                            : SizedBox()
                      ],
                    ),
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
  final Function onSelectDateButtonTrigrred;
  final Function onUploadButtonTrigrred;
  final Function onAddPhotoButtonTrigrred;
  final Function onPostButtonTrigrred;

  FeedsCard(
      {@required this.name,
      @required this.imageUrl,
      @required this.postImageFile,
      @required this.date,
      this.onSelectDateButtonTrigrred,
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
          Container(
            margin: EdgeInsets.only(left: 15, top: 15),
            child: FlatGradientButton(
              ontap: onSelectDateButtonTrigrred,
              width: 170,
              child: Text(
                'Select Date',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kBlackLessDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
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
                                text: (date == null)
                                    ? 'Select a date'
                                    : DateFormat.yMMMd()
                                        .format(date)
                                        .toString(),
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
