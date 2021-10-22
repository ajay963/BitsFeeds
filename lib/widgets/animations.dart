import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

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

class UploadFileAnimation extends StatelessWidget {
  final Widget child;
  UploadFileAnimation({this.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UploaderAnimation(),
              SizedBox(height: 20),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class UploaderAnimation extends StatefulWidget {
  const UploaderAnimation({Key key}) : super(key: key);
  @override
  _UploaderAnimationState createState() => _UploaderAnimationState();
}

class _UploaderAnimationState extends State<UploaderAnimation> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  bool get isPlaying => _controller?.isActive ?? false;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/animations/uploader.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.artboardByName('uploader');
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('Animation'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: _riveArtboard),
    );
  }
}
