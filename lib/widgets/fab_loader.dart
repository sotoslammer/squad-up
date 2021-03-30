import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'arc_painter.dart';

class FabLoader extends StatefulWidget {
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Widget child;

  FabLoader({
    this.color = Colors.orange,
    this.backgroundColor = Colors.transparent,
    this.strokeWidth = 4,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return _FabLoadingState(strokeWidth: strokeWidth, child: child);
  }
}

// Arc head will be lead by this Tween curve. This is for the first half of the
// animation, while the arc is growing from its head.
final Animatable<double> _kStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

// Arc tail will be lead by this Tween curve. This is for the second half of the
// animation, when the arc is shrinking from its tail.
final Animatable<double> _kStrokeTailTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

// The current progress step will be lead by this stepped Tween.
final Animatable<int> _kStepTween = StepTween(begin: 0, end: 5);

// The rotation for the arc as a whole will be lead by this Tween curve.
final Animatable<double> _kRotationTween = CurveTween(curve: const SawTooth(5));

class _FabLoadingState extends State<FabLoader>
    with SingleTickerProviderStateMixin {
  final Widget child;
  final double strokeWidth;

  late AnimationController _controller;

  _FabLoadingState({required this.strokeWidth, required this.child});

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void didUpdateWidget(FabLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    // We want to start animation again if the widget is updated.
    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // avoid leaks
    super.dispose();
  }

  Widget _buildIndicator(
      double headValue, double tailValue, int stepValue, double rotationValue) {
    return new CustomPaint(
      child: child,
      foregroundPainter: ArcPainter(
          strokeWidth: strokeWidth,
          backgroundColor: widget.backgroundColor,
          color: widget.color,
          headValue: headValue,
          tailValue: tailValue,
          stepValue: stepValue,
          rotationValue: rotationValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildIndicator(
          _kStrokeHeadTween.evaluate(_controller),
          _kStrokeTailTween.evaluate(_controller),
          _kStepTween.evaluate(_controller),
          _kRotationTween.evaluate(_controller),
        );
      },
    );
  }
}
