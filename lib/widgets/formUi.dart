import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';

class InputFormUI extends StatelessWidget {
  final Widget child;
  InputFormUI({this.child});
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.orange,
        child: SingleChildScrollView(
          // physics: ScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Image.asset(
                  'assets/png/lemonBG.png',
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  // subtracted 50 because image width is same
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width - 50),
                  width: MediaQuery.of(context).size.width,
                  color: Color(0x000efafe),
                  child: Stack(children: [
                    Container(
                      // this is not useless container rather it provides the
                      // overflow forward button

                      margin: EdgeInsets.only(top: 36),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      // margin: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      color: Color(0x00AAAAAA),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width - 140),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xaaFFB396),
                                      offset: Offset(0, 6),
                                      blurRadius: 12)
                                ]),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: korgShade3,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.grey[50],
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: child,
                          )
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
