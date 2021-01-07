import 'package:bits_news/component/constants.dart';
import 'package:bits_news/screens/homeScreen.dart';
import 'package:bits_news/widgets/formUi.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InputFormUI(
      child: SomeThings(),
    );
  }
}

class SomeThings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign In', style: TextStyle(fontSize: 42)),
            Container(
              margin: EdgeInsets.only(top: 40, right: 40),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                      fontSize: 24,
                      color: Color(0xff666666),
                      fontWeight: FontWeight.bold),

                  //prefixIcon: Icon(Icons.email_rounded),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,
                        color: Color(0xffCCCCCC),
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, right: 40),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      fontSize: 24,
                      color: Color(0xff666666),
                      fontWeight: FontWeight.bold),

                  //prefixIcon: Icon(Icons.email_rounded),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,
                        color: Color(0xffCCCCCC),
                        style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 18, color: korgShade4),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 60),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [korgShade2, korgShade3],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xaaFFB396),
                            offset: Offset(0, 0),
                            blurRadius: 20)
                      ]),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[50]),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
