import 'dart:async';
import 'dart:developer';
import 'dart:math' show pi;

import 'package:flutter/material.dart';

class CustomFlipAnimation extends StatefulWidget {
  const CustomFlipAnimation({
    Key? key,
    this.isHorizontal = true,
    required this.childOne,
    required this.childOnFlip,
  }) : super(key: key);

  final bool isHorizontal;
  final Widget childOne;
  final Widget childOnFlip;

  @override
  State<CustomFlipAnimation> createState() => _CustomFlipAnimationState();
}

class _CustomFlipAnimationState extends State<CustomFlipAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  // initialize _controller, _animation
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
    Timer.run(() {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    log(_status.toString());
    if (widget.isHorizontal) {
      return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateY(pi * _animation.value),
        child: Card(
          child: _animation.value <= 0.5 ? widget.childOne : widget.childOnFlip,
        ),
      );
    } else {
      return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateX(pi * _animation.value),
        child: Card(
          child: _animation.value <= 0.5 ? widget.childOne : RotatedBox(quarterTurns: 2, child: widget.childOnFlip),
        ),
      );
    }
  }
}
