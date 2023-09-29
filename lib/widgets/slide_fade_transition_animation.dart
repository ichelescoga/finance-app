import "package:flutter/material.dart";

class SlideFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  SlideFadeTransition({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeTransition(
          opacity: animation,
          child: child,
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 1.0), // From the bottom
            end: Offset.zero, // To the top
          ).animate(animation),
          child: child,
        ),
      ],
    );
  }
}
