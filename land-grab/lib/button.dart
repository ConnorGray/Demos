part of land_grab;

class Button extends Sprite {
  String _text;

  Button(this._text, {
      int width: 150, int height: 50, int fontSize: 14,
      int fillColor: Color.BlanchedAlmond,
      int strokeColor: Color.Black}) {
    this.graphics.beginPath();
    this.graphics.rectRound(0, 0, width, height, 8, 8);
    this.graphics.closePath();
    this.graphics.fillColor(fillColor);
    this.graphics.strokeColor(strokeColor, 2);

    this.pivotX = width / 2;
    this.pivotY = height / 2;

    String fonts =
      "Open Sans, Helvetica Neue, Helvetica, Arial, sans-serif";
    TextFormat textFormat =
      new TextFormat(fonts, fontSize, Color.Black,
          bold: true,
          align: TextFormatAlign.CENTER);

    TextField textField = new TextField()
      ..defaultTextFormat = textFormat
      ..x = 0
      ..width = width
      ..height = height
      ..cacheAsBitmap = false
      ..mouseEnabled = false
      ..text = this._text;
    textField.y = height/2 - textField.textHeight/1.7;

    addChild(textField);
  }

  animateTo(num scale, num alpha) {
    this.stage.juggler.removeTweens(this);
    this.stage.juggler.addTween(this, 0.25,
        Transition.easeOutQuadratic)
      ..animate.scaleX.to(scale)
      ..animate.scaleY.to(scale)
      ..animate.alpha.to(alpha);
  }
}