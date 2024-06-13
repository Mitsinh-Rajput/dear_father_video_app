import 'package:flutter/material.dart';

enum DialogTransition {
  right("right"),
  left("left"),
  top("top"),
  bottom("bottom"),
  center("center");

  const DialogTransition(this.value);
  final String value;
}

class ShowDialog {
  static Offset dialogTransition(DialogTransition type) {
    switch (type) {
      case DialogTransition.top:
        return const Offset(0.0, -1.0);
      case DialogTransition.bottom:
        return const Offset(0.0, 1.0);
      case DialogTransition.right:
        return const Offset(1.0, 0.0);
      case DialogTransition.left:
        return const Offset(-1.0, 0.0);
      default:
        return const Offset(0.0, 0.0);
    }
  }

  static Future getAnimatedDialog({
    required BuildContext context,
    required Widget child,
    required DialogTransition transitionType,
  }) async {
    return await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        Offset begin = dialogTransition(transitionType);
        Offset end = Offset.zero;
        Tween<Offset> tween = Tween(begin: begin, end: end);
        Animation<Offset> offsetAnimation = a1.drive(tween);
        if (transitionType == DialogTransition.center) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: child,
            ),
          );
        } else {
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return child;
      },
    );
  }

  static Future getNormalDialog({
    required BuildContext context,
    required Widget child,
  }) async {
    return await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return child;
      },
    );
  }
}
