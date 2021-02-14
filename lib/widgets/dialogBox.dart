import 'dart:ui';
import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';

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
