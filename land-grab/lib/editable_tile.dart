
class EditableTile extends Tile {
  EditableTile(String name, Player owner, String allegiance) : super(name, owner, allegiance) {


    this._draw();

    int startX = 0;
    int startY = 0;
    this._outline.onMouseDown.listen((var _) {
        startX = _points[0].x;
        startY = _points[0].y;

        this._outline.startDrag(true);
    });

    this._outline.onMouseUp.listen((var _) {
      this._outline.stopDrag();

      int deltaX = this._outline.x - startX;
      int deltaY = this._outline.y - startY;

      for (int i = 0; i < _points.length; i++) {
        _points[i].x += deltaX;
        _points[i].y += delatY;
      }

      this._draw();
    });
  }
}