part of land_grab;

class GameManager extends Manager {
  var subscriptions = new List<EventStreamSubscription>();

  GameManager(LandGrab landgrab) : super(landgrab) {
    print('created game manager!');

    if (landgrab.loadedMap == null) {
      print('redirecting to level select manager');
      landgrab.redirectState = GameState.LEVEL_SELECT;
      return;
    }

    landgrab.loadedMap.removeFromParent();
    this.addChild(landgrab.loadedMap);
  }

  void clean() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
  }

  void _onTileClick(Tile tile) {
    
  }
}