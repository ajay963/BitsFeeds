import 'package:bits_news/component/constants.dart';
import 'package:bits_news/modals/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styles = Provider.of<CustomStyles>(context);
    final ScrollController _scrollController = ScrollController();
    return SafeArea(
        child: SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    height: styles.imageSize,
                    width: styles.imageSize,
                    image: AssetImage('assets/png/explore.png')),
                Text('Explore',
                    style: TextStyle(fontSize: 42, color: korgShade3)),
                SizedBox(width: 50)
              ])
        ],
      ),
    ));
  }
}
