part of land_grab;

class LevelSelectManager extends Manager {
  var subscriptions = new List<EventStreamSubscription>();

  LevelSelectManager(LandGrab landgrab) : super(landgrab) {
    print('created level select manager!');

    Button levelCreatorButton = new Button("Create Level",
        width: 150, height: 50, fontSize: 20)
      ..x = LandGrab.WIDTH / 2
      ..y = 200;
    
    subscriptions.add(
        levelCreatorButton.onMouseOver.listen((var _) =>
            levelCreatorButton.animateTo(1.1, 1.0)));

    subscriptions.add(
        levelCreatorButton.onMouseOut.listen((var _) =>
            levelCreatorButton.animateTo(1.0, 1.0)));

    subscriptions.add(
        levelCreatorButton.onMouseClick.listen(
            _onLevelCreatorButtonPressed));

    this.addChild(levelCreatorButton);
  }

  void clean() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }

  void _onLevelCreatorButtonPressed(MouseEvent e) {
    this._landGrab.gameState = GameState.LEVEL_CREATOR;
  }
}