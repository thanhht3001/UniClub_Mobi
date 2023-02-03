import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import '../models/enums/enums.dart';
import '../utils/dimens.dart';

class FadeAnimation extends StatelessWidget {
  final double? delay;
  final Widget? child;

  FadeAnimation({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationProperties>()
      ..add(
          AnimationProperties.opacity,
          Tween(begin: Dimens.size0, end: Dimens.size1),
          const Duration(milliseconds: 500))
      ..add(
          AnimationProperties.translateY,
          Tween(begin: Dimens.sizeN30, end: Dimens.size0),
          const Duration(milliseconds: 500),
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AnimationProperties>>(
      delay: Duration(milliseconds: (500 * delay!).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AnimationProperties.opacity),
        child: Transform.translate(
            offset: Offset(
                Dimens.size0, animation.get(AnimationProperties.translateY)),
            child: child),
      ),
    );
  }
}
