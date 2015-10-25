part of land_grab;

class Dot extends Sprite {
  Dot(num xx, num yy) {
    this.x = xx;
    this.y = yy;

    this.graphics.beginPath();
    this.graphics.circle(0, 0, 4);
    this.graphics.closePath();
    this.graphics.fillColor(Color.Black);

    this.visible = false;

    this.onMouseOver.listen((var _) {
      this.scaleX = 1.5;
      this.scaleY = 1.5;
    });

    this.onMouseOut.listen((var _) {
      this.scaleX = 1.0;
      this.scaleY = 1.0;
    });

    // this.onMouseDown.listen((var _) {
    //   this.startDrag(false);
    // });

    // this.onMouseUp.listen((var _) {
    //   this.stopDrag();
    // });
  }
}