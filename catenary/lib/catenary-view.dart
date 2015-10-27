import 'package:polymer/polymer.dart';
import 'package:stagexl/stagexl.dart';
import 'dart:math' as math;

@CustomTag('catenary-view')
class CatenaryViewElement extends PolymerElement {
  static final int WIDTH = 600;
  static final int HEIGHT = 600;

  @observable final int DISPLAY_WIDTH = WIDTH;
  @observable final int DISPLAY_HEIGHT = HEIGHT;

  final Sprite p1 = _newPoint();
  final Sprite p2 = _newPoint();
  Shape line = new Shape();

  // StageXL Variables
  Stage stage = null;
  RenderLoop renderLoop = null;

  CatenaryViewElement.created() : super.created() {
    //---------------//
    // StageXL Setup //
    //---------------//
    
    StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
    this.stage = new Stage(shadowRoot.query('#stage'));
    this.renderLoop = new RenderLoop();
    this.renderLoop.addStage(this.stage);

    //------------//
    // Demo Setup //
    //------------//

    p1.x = (1 / 3.0) * WIDTH;
    p1.y = HEIGHT / 2;

    p2.x = (1 / 3.0) * WIDTH + 1;
    p2.y = HEIGHT / 3;

    p1.onMouseDown.listen(this._onMouseDown);
    p2.onMouseDown.listen(this._onMouseDown);

    p1.onMouseUp.listen(this._onMouseUp);
    p2.onMouseUp.listen(this._onMouseUp);

    this.stage.addChild(p1);
    this.stage.addChild(p2);
    this.stage.addChild(line);

    drawCatenary();
  }

  void _onMouseDown(MouseEvent event) {
    if (identical(event.target, p1) || identical(event.target, p2)) {
      (event.target as Sprite).startDrag(false);
    }
  }

  void _onMouseUp(MouseEvent event) {
    if (identical(event.target, p1) || identical(event.target, p2)) {
      (event.target as Sprite).stopDrag();
      drawCatenary();
    }
  }

  drawCatenary() {
    this.line.removeFromParent();
    this.line = new Shape();
    this.stage.addChild(this.line);

    final int STEPS = 200;

    final double minX = -1.0;
    final double maxX = 1.0;

    final double deltaX = (p2.x - p1.x).abs();
    final double deltaY = (p2.y - p1.y).abs();

    final double graphicsScaleFactor =
      math.sqrt( math.pow(p2.x - p1.x, 2) + math.pow(p2.y - p1.y, 2) );

    print(graphicsScaleFactor);

    double a = 2 * deltaX / deltaY;

    final double stepSize = (maxX - minX) / STEPS;

    line.graphics.beginPath();

    double x = minX;
    for (int step = 0; step <= STEPS; step++, x += stepSize) {
      double y = a * this.cosh(x / a);

      double displayX = x * graphicsScaleFactor + p1.x;
      double displayY = y * graphicsScaleFactor - p1.y;

      if (displayX > WIDTH || displayY > HEIGHT) {
        continue;
      }

      line.graphics.lineTo(displayX, displayY);
    }

    line.graphics.strokeColor(Color.Black, 2);
    line.graphics.closePath();
  }

  num sinh(num x) => (math.exp(x) - math.exp(-x)) / 2;
  num cosh(num x) => (math.exp(x) + math.exp(-x)) / 2;

  static Sprite _newPoint() {
    return new Sprite()
      ..graphics.beginPath()
      ..graphics.circle(0, 0, 6)
      ..graphics.closePath()
      ..graphics.fillColor(Color.Black)
      ..useHandCursor = true;
  }
}

// class CatenaryView extends DisplayObjectContainer {

//   void _drawCatenary() {
//     _line.removeFromParent();
//     _line = new Shape();
//     this.addChild(_line);

//     double r = _p1.x;
//     double s = _p1.y;
//     double u = _p2.x;
//     double v = _p2.y;
//     double l = 300.0;

//     double distance = math.sqrt( math.pow(_p2.y - _p1.y, 2) + math.pow(_p2.x - _p1.x, 2));
//     print('distance: $distance');

//     double z = 0.0;
//     while (  sinh(z) < math.sqrt(l*l - (v-s)*(v-s)) / (u-r)  ) {
//       z += 0.001;
//     }

//     double a = (u-r)/2/z;
//     double p = ( r+u - a*math.log((l+v-s) / (l-v+s)) ) / 2;
//     double q = ( v+s - l * cosh(z)/sinh(z)) / 2;

//     _line.graphics.moveTo(r, s);

//     double step = (u - x) / 10;
//     double offset = 0.0;
//     for (double x = r; x <= u; x++) {
//       // if (x == r) {
//       //   offset = s - (a * cosh((x-p) / a)+q);
//       //   print('setting offset: $offset');
//       // }
//       _line.graphics.lineTo(x, (a * cosh((x-p) / a)+q) + offset );
//     }

//     _line.graphics.strokeColor(Color.Black, 1);
//   }

// }