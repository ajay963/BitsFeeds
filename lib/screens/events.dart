import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return SafeArea(
      child: SingleChildScrollView(
          // physics: ScrollPhysics(parent: ),
          controller: _scrollController,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Events\n',
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w400,
                            color: kPkThemeShade1)),
                    TextSpan(
                        text: 'Track all the events',
                        style: TextStyle(
                            fontSize: 20,
                            color: kBlackLessDark,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
              ),
              SizedBox(height: 20),
            ],
          )),
    );
  }
}
