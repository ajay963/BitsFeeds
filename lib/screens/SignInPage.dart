import 'dart:ui';
import 'package:bits_news/Provider/styles.dart';
import 'package:bits_news/screens/signUp.dart';
import 'package:bits_news/widgets/glassMorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bits_news/Provider/authServices.dart';
import 'package:bits_news/component/constants.dart';
import 'package:bits_news/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image(
        image: AssetImage('assets/png/space01.jpg'),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.orange,
            child: SingleChildScrollView(child: SomeThings())),
      ),
    ]);
  }
}

class SomeThings extends StatefulWidget {
  @override
  _SomeThingsState createState() => _SomeThingsState();
}

class _SomeThingsState extends State<SomeThings> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final stylesAndControl = Provider.of<Styles>(context);
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3, left: 20, right: 20),
      child: GlassCard(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sign In',
              style: TextStyle(
                  fontSize: 42,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold)),
          Container(
              margin: EdgeInsets.only(top: 20, right: 40),
              child: UnderLinedTextField(
                fieldName: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              )),
          Container(
            margin: EdgeInsets.only(top: 20, right: 40),
            child: UnderLinedTextField(
              fieldName: 'Password',
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: true,
            ),
          ),
          SizedBox(height: 20),
          FlatGradientButton(
            ontap: () async {
              String mssg = await context.read<AuthenticationProvider>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim());
              stylesAndControl.setActionButtonState(getState: true);
              if (mssg != "True") {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MssgDialog(
                          title: 'Failed', mssg: mssg, context: context);
                    });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.signInAlt,
                  color: Colors.white,
                ),
                Text("Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          FlatGlassButton(
            ontap: () async {
              String mssg;
              mssg =
                  await context.read<AuthenticationProvider>().googleSignIn();
              stylesAndControl.setActionButtonState(getState: false);
              if (mssg != "True") {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MssgDialog(
                          title: 'Failed', mssg: mssg, context: context);
                    });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                Text("Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          FlatGlassButton(
            ontap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.white,
                ),
                Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      )),
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
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.3),
        title: Text(
          title,
          style: TextStyle(
              color: korgShade4, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        content: Text(mssg,
            style:
                TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 20)),
        actions: [
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white.withOpacity(0.2),
              onPressed: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Got It !',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 22),
                ),
              ))
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
