import 'dart:ui';
import 'package:bits_news/Provider/navBar.dart';
import 'package:bits_news/component/constants.dart';
import 'package:bits_news/screens/AddEvent.dart';
import 'package:bits_news/screens/AddPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BottomSheet());
                        });
                  },
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

class BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Container(
        height: 260,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Share Something',
                style: TextStyle(color: kPkThemeShade1, fontSize: 30)),
            SizedBox(height: 20),
            TextCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPostMain())),
                title: 'Post',
                content: 'add a post',
                icon: Icons.image),
            SizedBox(
              height: 30,
            ),
            TextCard(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEventMain())),
                title: 'Event',
                content: 'add an event',
                icon: Icons.event),
            SizedBox(height: 40)
          ],
        ),
        decoration: BoxDecoration(
          color: kWhiteBgColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Function onTap;
  TextCard(
      {@required this.title,
      @required this.content,
      @required this.icon,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 30),
            Icon(
              icon,
              size: 48,
            ),
            SizedBox(width: 10),
            RichText(
              text:
                  TextSpan(style: TextStyle(color: kBlackLessDark), children: [
                TextSpan(
                    text: title + '\n',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts.itim().fontFamily)),
                TextSpan(
                    text: content,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.delius().fontFamily))
              ]),
            )
          ]),
    );
  }
}
