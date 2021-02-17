import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bits_news/Provider/navBar.dart';
import 'package:flare_flutter/flare_actor.dart';

class NavBar extends StatelessWidget {
  final double size = 46;
  final double borderRadius = 36;
  final PageController pageController;

  NavBar({@required this.pageController});
  @override
  Widget build(BuildContext context) {
    final customNavBar = Provider.of<CustomNavBar>(context);
    // customNavBar.assignWidth(MediaQuery.of(context).size.width);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 60,
            //padding: EdgeInsets.only(top: 10),
            // margin: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height - 100),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.white.withOpacity(0.2),
              // boxShadow: [
              //   BoxShadow(
              //       color: kGreyDark.withOpacity(0.3),
              //       offset: Offset(0, 3),
              //       blurRadius: 16)
              // ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    customNavBar.itemsAssign(0);
                    customNavBar.selectedItem0();
                    pageController.jumpToPage(0);
                  },
                  child: Container(
                      height: size,
                      width: size,
                      margin: EdgeInsets.symmetric(
                          horizontal: customNavBar.itemsSpacing),
                      child: FlareActor('assets/navHome01.flr',
                          //  controller: navBarController.advance("Home", 30),
                          artboard: 'Home',
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: customNavBar.itemState0
                          //
                          //testing some features,
                          )),
                ),
                GestureDetector(
                  onTap: () {
                    customNavBar.itemsAssign(1);
                    customNavBar.selectedItem1();
                    pageController.jumpToPage(1);
                  },
                  child: Container(
                      height: size,
                      width: size,
                      margin: EdgeInsets.symmetric(
                          horizontal: customNavBar.itemsSpacing),
                      child: FlareActor('assets/navEvent01.flr',
                          artboard: 'Event',
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                          animation: customNavBar.itemState1)),
                ),
                GestureDetector(
                  onTap: () {
                    customNavBar.itemsAssign(2);
                    customNavBar.selectedItem2();
                    pageController.jumpToPage(2);
                  },
                  child: Container(
                      height: size,
                      width: size,
                      margin: EdgeInsets.symmetric(
                          horizontal: customNavBar.itemsSpacing),
                      child: FlareActor('assets/navExplore01.flr',
                          artboard: 'Explore',
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                          animation: customNavBar.itemState2)),
                )
              ],
            )),
      ),
    );
  }
}

class NavIndicator extends StatelessWidget {
  final double xPosition;
  NavIndicator({@required this.xPosition});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 200,
      ),
      alignment: Alignment(xPosition, -1),
    );
  }
}
