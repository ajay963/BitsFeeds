import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x55000000),
      body: Center(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width / 3,
            child: FlareActor(
              "assets/engine.flr",
              artboard: "Artboard",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "Untitled",
            ),
          ),
        ),
      ),
    );
  }
}
