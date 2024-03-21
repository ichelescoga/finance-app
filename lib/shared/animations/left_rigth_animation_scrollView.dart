import 'package:flutter/material.dart';

void leftRightAnimationScrollView(
    ScrollController scrollController, int durationSeconds) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    scrollController
        .animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: durationSeconds),
      curve: Curves.easeInOut,
    )
        .then((_) {
      scrollController.animateTo(
        0,
        duration: Duration(seconds: durationSeconds),
        curve: Curves.easeInOut,
      );
    });
  });
}
