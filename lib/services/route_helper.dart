import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Route getCustomRoute({
  required Widget child,
  Widget? currentChild,
  bool fullscreenDialog = false,
  bool animate = true,
  PageTransitionType type = PageTransitionType.rightToLeft,
  Alignment? alignment = Alignment.center,
  Duration duration = const Duration(milliseconds: 200),
  Duration reverseDuration = const Duration(milliseconds: 200),
}) {
  if (type == PageTransitionType.bottomToTopPop ||
      type == PageTransitionType.topToBottomPop ||
      type == PageTransitionType.leftToRightPop ||
      type == PageTransitionType.rightToLeftPop ||
      type == PageTransitionType.bottomToTopJoined ||
      type == PageTransitionType.topToBottomJoined ||
      type == PageTransitionType.leftToRightJoined ||
      type == PageTransitionType.rightToLeftJoined) {
    assert(currentChild != null, """
                When using type "bottomToTopPop" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
  }

  if (type == PageTransitionType.scale || type == PageTransitionType.size || type == PageTransitionType.rotate) {
    assert(alignment != null, """
                When using type "size" you need argument: 'alignment'
                """);
  }
  if (animate) {
    return PageTransition(
      type: type,
      alignment: (type == PageTransitionType.scale || type == PageTransitionType.size || type == PageTransitionType.rotate) ? alignment : null,
      duration: duration,
      reverseDuration: reverseDuration,
      child: child,
    );
  }
  return MaterialPageRoute(
    fullscreenDialog: fullscreenDialog,
    builder: (BuildContext context) {
      return child;
    },
  );
}
