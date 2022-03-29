import 'package:flutter/material.dart';

class DialogAnimation extends StatelessWidget {
  final Animation<double> animationValue;
  final Widget child;

  const DialogAnimation({
    Key? key,
    required this.animationValue,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: animationValue.value,
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: animationValue.value,
        duration: const Duration(milliseconds: 300),
        child: child,
      ),
    );
  }
}
