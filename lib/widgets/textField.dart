import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnderLinedTextField extends StatelessWidget {
  final String fieldName;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final TextEditingController controller;
  UnderLinedTextField(
      {this.keyboardType,
      this.controller,
      @required this.fieldName,
      this.obscureText = false,
      this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white, fontSize: 20),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),

        //prefixIcon: Icon(Icons.email_rounded),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Colors.white, style: BorderStyle.solid),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 3, color: Colors.white, style: BorderStyle.solid)),
        focusColor: korgShade2,
      ),
    );
  }
}

class BorderedTextField extends StatelessWidget {
  final String fieldName;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final int maxLines;
  BorderedTextField(
      {this.keyboardType,
      this.controller,
      @required this.fieldName,
      this.obscureText = false,
      this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        style: TextStyle(color: kBlackLessDark, fontSize: 20),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: TextStyle(
              fontSize: 18, color: kBlackDark, fontWeight: FontWeight.w500),

          //prefixIcon: Icon(Icons.email_rounded),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 3, color: kBlackLessDark, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 3, color: kBlackLessDark, style: BorderStyle.solid)),
          focusColor: korgShade2,
        ),
      ),
    );
  }
}

class BorderedColoredTextField extends StatelessWidget {
  final String fieldName;
  final Color color;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final int maxLines;
  BorderedColoredTextField(
      {this.keyboardType,
      this.color,
      this.controller,
      @required this.fieldName,
      this.obscureText = false,
      this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        style: TextStyle(color: kBlackLessDark, fontSize: 20),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: TextStyle(
              fontSize: 18, color: kBlackLessDark, fontWeight: FontWeight.w500),

          //prefixIcon: Icon(Icons.email_rounded),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 3, color: color, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 3, color: color, style: BorderStyle.solid)),
          focusColor: korgShade2,
        ),
      ),
    );
  }
}
