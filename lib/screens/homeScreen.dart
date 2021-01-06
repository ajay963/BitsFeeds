import 'package:bits_news/modals/navBar.dart';
import 'package:bits_news/widgets/navBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bits_news/screens/LoadingPage.dart';
//screens
import 'package:bits_news/screens/events.dart';
import 'package:bits_news/screens/FeedPage.dart';
import 'package:bits_news/screens/explore.dart';

class Home extends StatelessWidget {
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
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: NavBar(
          pageController: _pageController,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Loading()));
          },
          elevation: 4,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.pink,
            size: 40,
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.right,
            color: Colors.orange,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                customNavBar.itemsAssign(index);
              },
              children: _widgetPage,
            ),
          ),
        ));
  }
}
