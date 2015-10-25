library land_grab;

import 'package:stagexl/stagexl.dart';
//import 'dart:convert' show JSON;

part 'manager.dart';
part 'game_manager.dart';
part 'main_menu_manager.dart';
part 'level_select_manager.dart';
part 'level_creator_manager.dart';

part 'land_map.dart';
part 'dot.dart';
part 'tile.dart';
part 'player.dart';

part 'button.dart';

part 'game_state.dart';

class LandGrab extends DisplayObjectContainer {
  static final int WIDTH = 960;
  static final int HEIGHT = 540;

  GameState _gameState = GameState.MAIN_MENU;

  // To be set only in a manager constructor when the current
  // game state is not proper for its existance.
  GameState redirectState = GameState.MAIN_MENU;

  GameState get gameState => this._gameState;

  LandMap loadedMap = null;

  void set gameState(GameState newState) {
    this._gameState = newState;
    _loadStateManager(newState);
  }
  
  Stage _stage = null;
  RenderLoop _renderLoop = null;

  Manager _manager = null;

  LandGrab(this._stage, this._renderLoop) {
    this._stage.addChild(this);
    this.gameState = GameState.MAIN_MENU;
  }

  void _loadStateManager(GameState state,
      {bool setRedirectToNull: false}) {
    if (setRedirectToNull) {
      redirectState = null;
    }

    if (this._manager != null) {
      _manager.clean();
      _manager.removeFromParent();
    }

    switch (state) {
    case GameState.MAIN_MENU:
      _manager = new MainMenuManager(this);
      break;
    case GameState.LEVEL_SELECT:
      _manager = new LevelSelectManager(this);
      break;
    case GameState.LEVEL_CREATOR:
      _manager = new LevelCreatorManager(this);
      break;
    case GameState.IN_GAME:
      _manager = new GameManager(this);
      break;
    }

    if (redirectState != null) {
      this._loadStateManager(redirectState, setRedirectToNull: true);
      return;
    }

    this.addChild(this._manager);
  }
}
