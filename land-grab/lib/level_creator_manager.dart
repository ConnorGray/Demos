part of land_grab;

class LevelCreatorManager extends Manager {
  var subscriptions = new List<EventStreamSubscription>();

  int _currentColor = Color.Red;

  LevelCreatorManager(LandGrab landgrab) : super(landgrab) {
    print('created level creator manager!');

    if (landgrab.loadedMap == null) {
      landgrab.loadedMap = new LandMap("New Map");
    }
    landgrab.loadedMap.editable = true;
    this.addChild(landgrab.loadedMap);

    Shape rectangle = new Shape();
    rectangle.graphics.beginPath();
    rectangle.graphics.rect(0, 0, 96, LandGrab.HEIGHT);
    rectangle.graphics.closePath();
    rectangle.graphics.fillColor(Color.Black);
    rectangle.graphics.strokeColor(Color.Black, 1);
    rectangle.x = LandGrab.WIDTH - 96;
    rectangle.y = 0;
    this.addChild(rectangle);

    Button addTileButton = new Button("Add tile",
        width: 96, height: 40, fontSize: 12)
      ..x = LandGrab.WIDTH - 96/2
      ..y = LandGrab.HEIGHT - 40/2;

    subscriptions.add(
        addTileButton.onMouseOver.listen((var _) =>
            addTileButton.animateTo(1.1, 1.0)));

    subscriptions.add(
        addTileButton.onMouseOut.listen((var _) =>
            addTileButton.animateTo(1.0, 1.0)));

    subscriptions.add(
        addTileButton.onMouseClick.listen((var _) =>
            landgrab.loadedMap.addTile(new Tile(_currentColor, null)
                ..x = LandGrab.WIDTH/2 - 96/2
                ..y = LandGrab.HEIGHT / 2)));

    this.addChild(addTileButton);

    for (int i = 0; i < LandMap.colors.length; i++) {
      Sprite colorSquare = new Sprite();
      colorSquare.graphics.beginPath();
      colorSquare.graphics.rect(0, 0, 39, 39);
      colorSquare.graphics.closePath();
      colorSquare.graphics.fillColor(LandMap.colors[i]);

      colorSquare.x = LandGrab.WIDTH - 96 + 6;

      if (i >= 4) {
        colorSquare.x += 39 + 6; 
      }
      colorSquare.y = (i % 4) * (39 + 6) + 6;

      colorSquare.onMouseClick.listen((var _) {
        this._currentColor = LandMap.colors[i];
      });

      this.addChild(colorSquare);
    }
  }

  void clean() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }
}