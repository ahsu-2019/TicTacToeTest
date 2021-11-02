import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//This is a dart file containing shadermasks for our play button
//Andrew Hsu 11/2/21
Color playbuttonmask1 = Colors.lightBlueAccent;
Color playbuttonmask2 = Colors.pinkAccent;
class playButtonMask extends StatelessWidget {
  playButtonMask({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomCenter,
        radius: 0.35,
        colors: [playbuttonmask1, playbuttonmask2],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}