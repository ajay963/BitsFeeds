import 'package:bits_news/Provider/authServices.dart';
import 'package:bits_news/component/constants.dart';
import 'package:bits_news/screens/AddPost.dart';
// import 'package:bits_news/screens/ClubPage.dart';
// import 'package:bits_news/screens/AddPost.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthenticationProvider>(context);

    return SafeArea(
        child: ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        color: korgShade3,
        axisDirection: AxisDirection.down,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Explore\n',
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w400,
                              color: kPkThemeShade1)),
                      TextSpan(
                          text: 'Searching something else',
                          style: TextStyle(
                              fontSize: 20,
                              color: kBlackLessDark,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                ),
                SizedBox(height: 20),
                GradientCards(
                    onTap: () {},
                    title: 'Contribute',
                    subTitle: 'Do some contribution',
                    icon: FontAwesomeIcons.code),
                GradientCards(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddPostMain())),
                    // onTap: () => Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AddPost())),
                    title: 'Societies',
                    subTitle: 'take a glimpse of clubs ',
                    icon: FontAwesomeIcons.fire),
                GradientCards(
                    onTap: () {},
                    title: 'About',
                    subTitle: 'Short brief of this app',
                    icon: Icons.info),
                GradientCards(
                    onTap: () {},
                    title: 'Network',
                    subTitle: 'check your network status',
                    icon: FontAwesomeIcons.broadcastTower),
                GradientCards(
                    onTap: () {
                      authServices.signOut();
                    },
                    title: 'LogOut',
                    subTitle: 'Sign in with Diff. account',
                    icon: FontAwesomeIcons.signOutAlt)
              ]),
        ),
      ),
    ));
  }
}

class GradientCards extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function onTap;
  GradientCards(
      {@required this.title,
      @required this.subTitle,
      @required this.icon,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width - 50,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: InkWell(
          onTap: onTap,
          splashColor: kPkThemeShade1,
          child: Ink(
            height: 80,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: title + '\n',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: kBlackLessDark)),
                      TextSpan(
                          text: subTitle,
                          style: TextStyle(
                              fontSize: 18,
                              color: kBlackLessDark,
                              fontWeight: FontWeight.w600))
                    ]),
                  ),
                  Container(
                    // this container for circular button
                    height: 60,
                    width: 60,
                    child: Icon(
                      icon,
                      color: kBlackLessDark,
                      size: 36,
                    ),
                    decoration: BoxDecoration(
                      color: kWhiteBgColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
                gradient: kThemeGradient,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
