import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';

mixin HubFlarePullController implements FlareController {
  ActorAnimation pullAnimation;

  double pulledExtentFlare = 0;
  double speed = 2.0;
  double rockTime = 0.0;

  bool get getPlayAuto;
  double get refreshTriggerPullDistance => 140;

  @override
  void initialize(FlutterActorArtboard artboard) {
    this.pullAnimation = artboard.getAnimation('Earth Moving');
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (getPlayAuto) {
      this.rockTime += elapsed * this.speed;
      this.pullAnimation.apply(this.rockTime % this.pullAnimation.duration, artboard, 1.0);
      return true;
    }

    var pullExtent = (pulledExtentFlare > refreshTriggerPullDistance)
        ? pulledExtentFlare - refreshTriggerPullDistance
        : pulledExtentFlare;
    double animationPosition = pullExtent / refreshTriggerPullDistance;
    animationPosition *= animationPosition;
    this.rockTime = this.pullAnimation.duration * animationPosition;
    this.pullAnimation.apply(this.rockTime, artboard, 1);
    return true;
  }
}