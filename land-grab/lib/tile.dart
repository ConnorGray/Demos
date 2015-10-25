part of land_grab;

class Tile extends Sprite {
  String allegiance = null; 
  int color = null;

  List<Dot> _dots = new List<Dot>();

  bool _editable = false;

  bool get editable => this._editable;
  void set editable(bool e) {
    this._editable = e;
    for (Dot dot in _dots) {
      dot.visible = e;
    }
  }

  Tile(this.color, this.allegiance) {
    Dot bottomLeft =
      new Dot(-20, 20);
    Dot bottomRight =
      new Dot(20, 20);
    Dot topCenter =
      new Dot(0, -20);

    this.addDot(bottomLeft);
    this.addDot(bottomRight);
    this.addDot(topCenter);

    _initListeners();
    _draw();
  }

  Tile.fromMap(Map data) {
    this.color = data['color'];
    this.allegiance = data['allegiance'];

    _initListeners();
    _draw();
  }

  void _initListeners() {
    this.onMouseDown.listen((MouseEvent e) {
      if (this._editable) {
        if (e.target is Dot) {
          (e.target as Dot).startDrag(false);
        } else {
          this.startDrag(false);
        }
      }
    });

    this.onMouseUp.listen((MouseEvent e) {
      if (e.target is Dot) {
        (e.target as Dot).stopDrag();
      } else {
        this.stopDrag();
      }
      _draw();
    });

    this.onMouseMove.listen((MouseEvent e) {
      _draw();
    });
  }

  void addDot(Dot dot) {
    this._dots.add(dot);
    this.addChild(dot);
  }

  void _draw() {
    this.graphics.clear();

    this.graphics.beginPath();
    this.graphics.moveTo(_dots[0].x, _dots[0].y);

    for (Dot dot in _dots) {
      this.graphics.lineTo(dot.x, dot.y);
    }
    this.graphics.closePath();
    this.graphics.strokeColor(Color.Black, 2);

    if (color != null) {
      this.graphics.fillColor(color);
    } else {
      this.graphics.fillColor(Color.LightGray);
    }
  }
}