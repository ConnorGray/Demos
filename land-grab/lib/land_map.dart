part of land_grab;

class LandMap extends DisplayObjectContainer {
  static final List<int> colors = [
    Color.Red,
    Color.Green,
    Color.Blue,
    Color.Yellow,
    Color.Purple,
    Color.Pink,
    Color.Cyan,
    Color.Black
  ];

  String title = null;
  List<Tile> _tiles = new List<Tile>();

  bool _editable = false;

  bool get editable => this._editable;
  void set editable(bool e) {
    this._editable = e;
    for (int i = 0; i < _tiles.length; i++) {
      _tiles[i].editable = e;
    }
  }

  LandMap(this.title) {
  }

  LandMap.fromMap(Map data) {
    this.title = data['title'];

    List<Map> tileDataList = data['tiles'];
    for (Map tileData in tileDataList) {
      this.addTile(new Tile.fromMap(tileData));
    }
  }

  void addTile(Tile tile) {
    tile.editable = this._editable;
    this._tiles.add(tile);
    this.addChild(tile);
  }

  void removeTile(Tile tile) {
    this._tiles.remove(tile);
    this.removeChild(tile);
  }
}