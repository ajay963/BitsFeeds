import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';

class RaisedWhiteButton extends StatelessWidget {
  final Widget child;
  final Function ontap;
  RaisedWhiteButton({@required this.ontap, this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              color: Colors.white.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                    color: kBlackDark.withOpacity(0.2),
                    offset: Offset(0, 0),
                    blurRadius: 20)
              ]),
          child: child),
    );
  }
}

class Buttons extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  Buttons({this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onTap,
        child: Icon(icon),
        hoverColor: korgShade2.withOpacity(0.4));
  }
}
