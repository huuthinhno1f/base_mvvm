import 'package:flutter/material.dart';

class WidgetAnimationSlideTransition extends StatefulWidget {
  final Widget child;
  final Duration? durationAnimation;
  const WidgetAnimationSlideTransition(
      {Key? key, required this.child, this.durationAnimation})
      : super(key: key);
  @override
  State<WidgetAnimationSlideTransition> createState() =>
      _WidgetAnimationSlideTransitionState();
}

class _WidgetAnimationSlideTransitionState
    extends State<WidgetAnimationSlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.durationAnimation ?? const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
