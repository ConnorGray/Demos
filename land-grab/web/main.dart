import 'dart:html';
import 'package:stagexl/stagexl.dart';

import 'package:land_grab/land_grab.dart';

void main() {
  CanvasElement canvas = querySelector('#stage');
  Stage stage = new Stage(canvas);
  RenderLoop renderLoop = new RenderLoop();

  renderLoop.addStage(stage);

  LandGrab game = new LandGrab(stage, renderLoop);
}
