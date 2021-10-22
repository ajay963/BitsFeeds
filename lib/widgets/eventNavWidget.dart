import 'package:bits_news/Provider/eventNav.dart';
import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventNavWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      constraints: BoxConstraints(
        minHeight: 10,
        maxHeight: 200,
        minWidth: 100,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Align(
          alignment: Alignment.bottomCenter, child: EventNavMainFunctionOnly()),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kWhiteBgColor.withOpacity(0), kWhiteBgColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}

class EventNavMainFunctionOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<EventNav>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      width: 100,
      height: 50,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularDotsForNav(
              bigSizeState: (currentPage.eventCurrentPage == 0) ? true : false),
          CircularDotsForNav(
              bigSizeState: (currentPage.eventCurrentPage == 1) ? true : false),
          CircularDotsForNav(
              bigSizeState: (currentPage.eventCurrentPage == 2) ? true : false),
        ],
      ),
    );
  }
}

class CircularDotsForNav extends StatelessWidget {
  final bool bigSizeState;
  CircularDotsForNav({@required this.bigSizeState});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      height: (bigSizeState) ? 24 : 14,
      width: (bigSizeState) ? 24 : 14,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (bigSizeState) ? kBlackLessDark : kGreyDark),
    );
  }
}
