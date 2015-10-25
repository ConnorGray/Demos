import 'dart:html';
import 'package:stagexl/stagexl.dart';
import 'package:polymer/polymer.dart';
import 'dart:math';
import 'dart:async';

@CustomTag('buffons-needle')
class BuffonsNeedleElement extends PolymerElement {
  @observable final int HEIGHT = 600;
  @observable final int WIDTH = 600;

  @observable int numberOfSticksToAdd = 1000;
  @observable int totalSticks = 0;
  @observable int crossedSticks = 0;
  @observable double ratio = 0.0;

  // StageXL Variables
  Stage stage = null;
  RenderLoop renderLoop = null;

  final random = new Random();

  BuffonsNeedleElement.created() : super.created() {
    StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
    CanvasElement canvas = shadowRoot.query('#stage');
    this.stage = new Stage(canvas);
    this.renderLoop = new RenderLoop();
    this.renderLoop.addStage(stage);

    this._grid.graphics.beginPath();
    for (int i = 0; i < (WIDTH / t).toInt() + 1; i++) {
      _grid.graphics.moveTo(t * i, 0);
      _grid.graphics.lineTo(t * i, HEIGHT);
    }
    this._grid.graphics.strokeColor(Color.Red, 1);
    this._grid.graphics.closePath();

    this.stage.addChild(this._grid);
    // this.stage.onEnterFrame.listen(this._onEnterFrame);
  }

  final int t = 60; // Distance between parallel lines
  final int l = 60; // Length of each stick

  Shape _grid = new Shape();

  void addSticks() {
    this.stage.removeChildren();
    this.stage.addChild(this._grid);

    for (int i = 0; i < this.numberOfSticksToAdd; i++) {
      Shape stick = _initStick();
      stick.rotation = this.random.nextDouble() * 2*PI;
      stick.x = this.random.nextInt(this.WIDTH);
      stick.y = this.random.nextInt(this.HEIGHT);
      this.stage.addChild(stick);

      this.totalSticks++;

      int relativeX = stick.x % t;
      double stickCosLength = (l/2) * sin(stick.rotation);

      if (relativeX < t / 2) {
        if (relativeX - stickCosLength <= 0) {
          this.crossedSticks++;
        }
      } else if (relativeX > t / 2) {
        if (relativeX + stickCosLength > t) {
          this.crossedSticks++;
        }
      }
    }

    this.ratio = this.totalSticks / this.crossedSticks;
  }

  Shape _initStick() {
    return new Shape()
      ..graphics.beginPath()
      ..graphics.moveTo(-l/2, 0)
      ..graphics.lineTo( l/2, 0)
      ..graphics.strokeColor(Color.Black, 1)
      ..graphics.closePath();
  }

  void _onEnterFrame(EnterFrameEvent e) {
    addSticks();
  }
}