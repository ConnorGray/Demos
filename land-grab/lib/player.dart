part of land_grab;

class Player {
  String name = null;
  int color = null;

  Player(this.name, this.color);

  Player.fromMap(Map data) {
    this.name = data['name'];
    this.color = data['color'];
  }
}