import 'package:flutter/material.dart';

class CustomSlideAnimation extends StatefulWidget {
  const CustomSlideAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.elasticOut,
    this.start = Alignment.centerLeft,

    ///Do not change end
    this.end = Alignment.center,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Curve curve;
  final Alignment start;

  ///Do not change end
  final Alignment end;

  @override
  State<CustomSlideAnimation> createState() => _CustomSlideAnimationState();
}

class _CustomSlideAnimationState extends State<CustomSlideAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
