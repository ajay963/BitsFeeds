import 'package:bits_news/Provider/authServices.dart';
import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// import 'package:bits_news/screens/AddPost.dart';
// import 'package:bits_news/screens/ClubPage.dart';
// import 'package:bits_news/screens/ClubPage.dart';
// import 'package:bits_news/screens/AddPost.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthenticationProvider>(context);

    return SafeArea(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontFamily: GoogleFonts.itim().fontFamily,
                    ),
                    children: [
                      TextSpan(
                          text: 'Explore\n',
                          style: Theme.of(context).textTheme.headline1),
                      TextSpan(
                          text: 'Searching something else',
                          style: Theme.of(context).textTheme.headline2)
                    ]),
              ),
            ),
            SizedBox(height: 40),
            GradientCards(
                onTap: () {},
                title: 'Contribute',
                subTitle: 'Do some contribution',
                icon: FeatherIcons.code),
            GradientCards(
                onTap: () {},

                // onTap: () => Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddPost())),
                title: 'Societies',
                subTitle: 'take a glimpse of clubs ',
                icon: FeatherIcons.activity),
            GradientCards(
                onTap: () {},
                title: 'club Info',
                subTitle: 'Short brief of the club',
                icon: Icons.info),
            GradientCards(
                onTap: () {},
                title: 'Network',
                subTitle: 'check your network status',
                icon: FeatherIcons.info),
            GradientCards(
                onTap: () {
                  authServices.signOut();
                },
                title: 'LogOut',
                subTitle: 'Sign in with Diff. account',
                icon: FeatherIcons.atSign)
          ]),
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
        margin: EdgeInsets.only(top: 6, bottom: 6),
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
                            style: Theme.of(context).textTheme.headline3),
                        TextSpan(
                            text: subTitle,
                            style: Theme.of(context).textTheme.bodyText2)
                      ]),
                    ),
                    Container(
                      // this container for circular button
                      height: 50,
                      width: 50,
                      child: Icon(
                        icon,
                        color: Theme.of(context).textTheme.bodyText2.color,
                        size: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).shadowColor,
                      offset: Offset(0, 4),
                      blurRadius: 10)
                ],
              )),
        ),
      ),
    );
  }
}
