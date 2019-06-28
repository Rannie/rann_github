import 'dart:math';

import 'package:flutter/material.dart';

class CustomBouncingScrollPhysics extends ScrollPhysics {
  final double refreshHeight;

  const CustomBouncingScrollPhysics({
    ScrollPhysics parent,
    this.refreshHeight = 140
  }) : super (parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  double frictionFactor(double overScrollFraction) => 
      0.52 * pow(1 - overScrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);
    if (!position.outOfRange) {
      return offset;
    }

    final double overScrollPastStart =
        max(position.minScrollExtent - position.pixels, 0.0);
    final double overScrollPastEnd =
        max(position.pixels - position.maxScrollExtent, 0.0);
    final double overScrollPast = max(overScrollPastStart, overScrollPastEnd);

    final bool easing = (overScrollPastStart > 0.0 && offset < 0.0) ||
        (overScrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing ? frictionFactor(
        (overScrollPast - offset.abs()) / position.viewportDimension) :
        frictionFactor(overScrollPast / position.viewportDimension);

    final double direction = offset.sign;

    return direction * _applyFriction(overScrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
      double extentOutside, double absDelta, double gamma)
  {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }
}