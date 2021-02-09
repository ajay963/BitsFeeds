import 'package:bits_news/Provider/navBar.dart';
//import 'package:bits_news/Provider/styles.dart';
import 'package:bits_news/component/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//screens
import 'package:bits_news/screens/events.dart';
import 'package:bits_news/screens/FeedPage.dart';
import 'package:bits_news/screens/explore.dart';

class Home extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final String userDataId =
      FirebaseAuth.instance.currentUser.providerData[0].providerId;
  final List<Widget> _widgetPage = <Widget>[
    FeedPage(),
    EventPage(),
    ExplorePage()
  ];
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(
      initialPage: 0,
    );
    final customNavBar = Provider.of<CustomNavBar>(context);
    //  final styleAndControl = Provider.of<Styles>(context);
    return Scaffold(
        extendBody: true,
        backgroundColor: kWhiteBgColor,
        // bottomNavigationBar: NavBar(
        //   pageController: _pageController,
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (userDataId == 'password')
            ? Container(
                height: 70,
                width: 70,
                child: RawMaterialButton(
                  onPressed: () {},
                  shape: CircleBorder(),
                  //  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                  fillColor: kMVThemeShade1,
                  child: Icon(
                    Icons.add,
                    size: 46,
                    color: kWhiteBgColor,
                  ),
                ),
              )
            : SizedBox(height: 0),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.right,
            color: kPkThemeShade1,
            child: PageView(
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                customNavBar.itemsAssign(index);
              },
              children: _widgetPage,
            ),
          ),
        ));
  }
}
