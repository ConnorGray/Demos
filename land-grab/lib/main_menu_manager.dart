part of land_grab;

class MainMenuManager extends Manager {
  var subscriptions = new List<EventStreamSubscription>();

  MainMenuManager(LandGrab landgrab) : super(landgrab) {
    Button newGameButton = new Button("New Game",
        width: 220, height: 80, fontSize: 25);
    newGameButton.x = LandGrab.WIDTH / 2;
    newGameButton.y = LandGrab.HEIGHT / 2;

    subscriptions.add(
        newGameButton.onMouseOver.listen((var _) =>
            newGameButton.animateTo(1.1, 1.0)));
    subscriptions.add(
        newGameButton.onMouseOut.listen((var _) =>
            newGameButton.animateTo(1.0, 1.0)));

    subscriptions.add(
        newGameButton.onMouseClick.listen(_onNewGameButtonPressed));

    this.addChild(newGameButton);
  }

  void clean() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }

  _onNewGameButtonPressed(MouseEvent e) {
    this._landGrab.gameState = GameState.IN_GAME;
  }
}