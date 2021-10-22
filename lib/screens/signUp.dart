import 'dart:io';
import 'package:bits_news/Provider/authServices.dart';
import 'package:bits_news/component/constants.dart';
import 'package:bits_news/customPainter/curvePath.dart';
import 'package:bits_news/services/cloudServices.dart';
import 'package:bits_news/services/firestoreService.dart';
import 'package:bits_news/widgets/buttons.dart';
import 'package:bits_news/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File imageFile;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final picker = ImagePicker();
  final TextEditingController _clubNameController = TextEditingController();

  final TextEditingController _clubEmailController = TextEditingController();

  final TextEditingController _instituteController = TextEditingController();

  final TextEditingController _motiveController = TextEditingController();

  final TextEditingController _aboutController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  Future<bool> signUp({String email, String password}) async {
    String mssg;

    mssg = await context
        .read<AuthenticationProvider>()
        .signUp(email: email, password: password);
    if (mssg == "True") {
      return true;
    } else if (mssg != "True") {
      await showDialog(
          context: context,
          builder: (context) =>
              MssgDialog(title: 'Failed', mssg: mssg, context: context));
      return false;
    }
    return false;
  }

  Future getImageFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
        showDialog(
            context: context,
            builder: (context) => MssgDialog(
                title: 'Failed', mssg: 'Image Not Picked', context: context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cloudService = Provider.of<CloudStorageService>(context);

    signUpCollection(
        {String clubName,
        String instituteName,
        String about,
        String motives,
        @required String imageUrl,
        String email,
        String password,
        String userId}) async {
      FirestoreService fireStoreService = FirestoreService();
      await fireStoreService.clubData(
          clubName: clubName,
          email: email,
          instituteName: instituteName,
          about: about,
          motives: motives,
          imageUrl: imageUrl,
          userId: userId);
      await cloudService.cloudServiceVariableReset();
    }

    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          color: Colors.orange,
          axisDirection: AxisDirection.down,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image(
                    image: imageFile == null
                        ? AssetImage('assets/png/2.jpg')
                        : FileImage(imageFile),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width - 100),
                  child: CustomPaint(
                    size: Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.width *
                            0.5), //You can Replace this with your desired WIDTH and HEIGHT
                    painter: CustomPainterConcaveCurve(),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width,
                        left: 20,
                        right: 20),
                    child: Container(
                      child: Column(
                        children: [
                          Text('Sign Up',
                              style: TextStyle(
                                  color: kBlackDark,
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 40),
                          cloudService.isUploading == true
                              ? Container(
                                  child: Center(
                                    child: Text(
                                        'Uploading.. ${cloudService.dataTransferSize}KB out of ${cloudService.totalDataSize}KB',
                                        style: TextStyle(
                                            color: kBlackDark, fontSize: 16)),
                                  ),
                                )
                              : SizedBox(height: 2),
                          (cloudService.isSucess == true)
                              ? BorderedTextField(
                                  fieldName: 'Club Name',
                                  keyboardType: TextInputType.name,
                                  controller: _clubNameController,
                                )
                              : SizedBox(height: 0),
                          (cloudService.isSucess == true)
                              ? BorderedTextField(
                                  fieldName: 'Club E-mail address',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _clubEmailController)
                              : SizedBox(height: 0),
                          (cloudService.isSucess == true)
                              ? BorderedTextField(
                                  fieldName: 'Institute Name',
                                  keyboardType: TextInputType.streetAddress,
                                  controller: _instituteController)
                              : SizedBox(height: 0),
                          (cloudService.isSucess == true)
                              ? BorderedTextField(
                                  fieldName: 'Motives',
                                  keyboardType: TextInputType.multiline,
                                  controller: _motiveController,
                                  maxLines: 5,
                                )
                              : SizedBox(height: 0),
                          (cloudService.isSucess == true)
                              ? BorderedTextField(
                                  fieldName: 'About Club',
                                  keyboardType: TextInputType.multiline,
                                  controller: _aboutController,
                                  maxLines: 5,
                                )
                              : SizedBox(height: 0),
                          (cloudService.isSucess == true)
                              ? BorderedTextField(
                                  fieldName: 'Password',
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  controller: _passwordController,
                                )
                              : SizedBox(height: 2),
                          (cloudService.isSucess == true)
                              ? RaisedWhiteButton(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: korgShade3,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ontap: () async {
                                    if (_clubNameController.text.isNotEmpty &&
                                        _passwordController.text.isNotEmpty &&
                                        _clubEmailController.text.isNotEmpty &&
                                        _aboutController.text.isNotEmpty &&
                                        _motiveController.text.isNotEmpty &&
                                        _instituteController.text.isNotEmpty &&
                                        imageFile != null) {
                                      bool mssg = await signUp(
                                          email:
                                              _clubEmailController.text.trim(),
                                          password:
                                              _passwordController.text.trim());
                                      if (mssg == true) {
                                        User userId = context
                                            .read<AuthenticationProvider>()
                                            .getUserId();

                                        print(
                                            '\n\nurl in pass junction: ${cloudService.imageUrl}');
                                        await signUpCollection(
                                            clubName:
                                                _clubNameController.text.trim(),
                                            email: _clubEmailController.text
                                                .trim(),
                                            motives:
                                                _motiveController.text.trim(),
                                            imageUrl: cloudService.imageUrl,
                                            about: _aboutController.text.trim(),
                                            instituteName: _instituteController
                                                .text
                                                .trim(),
                                            userId: userId.uid);
                                        imageFile.delete();
                                        cloudService
                                            .cloudServiceVariableReset();
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      String mssg = 'Some Fields are missing';
                                      showDialog(
                                          context: context,
                                          builder: (context) => MssgDialog(
                                              title: 'Failed',
                                              mssg: imageFile == null
                                                  ? 'Please Select an Image'
                                                  : mssg,
                                              context: context));
                                    }
                                  },
                                )
                              : SizedBox(height: 0),
                          (cloudService.isSucess == false)
                              ? RaisedWhiteButton(
                                  ontap: getImageFile,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        color: korgShade3,
                                      ),
                                      Text(
                                        'Add',
                                        style: TextStyle(
                                            color: korgShade3,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(height: 2),
                          (cloudService.isSucess == false)
                              ? RaisedWhiteButton(
                                  ontap: () async {
                                    (imageFile != null)
                                        ? await cloudService.clubImageUpload(
                                            imageFileToUpload: imageFile)
                                        : showDialog(
                                            context: context,
                                            builder: (context) => MssgDialog(
                                                title: 'Error',
                                                mssg: 'Please Select an Image',
                                                context: context));
                                  },
                                  child: Text('Upload',
                                      style: TextStyle(
                                          color: korgShade3,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)))
                              : SizedBox(height: 2),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MssgDialog extends StatelessWidget {
  final String title;
  final String mssg;
  final BuildContext context;
  MssgDialog(
      {@required this.title, @required this.mssg, @required this.context});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
            color: korgShade3, fontSize: 28, fontWeight: FontWeight.bold),
      ),
      content:
          Text(mssg, style: TextStyle(color: kBlackLessDark, fontSize: 20)),
      actions: [
        RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: korgShade3,
            onPressed: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Got It !',
                style: TextStyle(color: kGreylight, fontSize: 24),
              ),
            ))
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
