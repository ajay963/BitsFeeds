import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bits_news/modals/navBar.dart';
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
    return Container(
        //width: 200,
        margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: MediaQuery.of(context).size.width * (3 / 17)),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0x30000000), offset: Offset(0, 10), blurRadius: 16)
          ],
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
        ));
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
