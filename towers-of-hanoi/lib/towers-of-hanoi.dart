import 'dart:html';
import 'package:stagexl/stagexl.dart';
import 'package:polymer/polymer.dart';
import 'package:towers_of_hanoi/solvers.dart' as solvers;
import 'dart:math';
import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

@CustomTag('towers-of-hanoi')
class TowersOfHanoiElement extends PolymerElement {
  static final int HEIGHT = 600;
  static final int WIDTH = 1000;

  static final int MAX_DISK_WIDTH = (WIDTH / 4.0).toInt();

  @observable final int DISPLAY_HEIGHT = HEIGHT;
  @observable final int DISPLAY_WIDTH = WIDTH;

  @observable int numberOfDisks = 5;
  @observable int steps = 0;

  final int towerACenter = ((WIDTH / 4.0) * 1).toInt();
  final int towerBCenter = ((WIDTH / 4.0) * 2).toInt();
  final int towerCCenter = ((WIDTH / 4.0) * 3).toInt();

  final List<Queue<Shape>> towers = new List<Queue<Shape>>()
    ..add(new Queue<Shape>())
    ..add(new Queue<Shape>())
    ..add(new Queue<Shape>());

  // StageXL Variables
  Stage stage = null;
  RenderLoop renderLoop = null;

  final random = new Random();

  List<List<int>> _moves;

  TowersOfHanoiElement.created() : super.created() {
    StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
    CanvasElement canvas = shadowRoot.query('#stage');
    this.stage = new Stage(canvas);
    this.renderLoop = new RenderLoop();
    this.renderLoop.addStage(stage);

    this.stage.addChild(_createTower(towerACenter));
    this.stage.addChild(_createTower(towerBCenter));
    this.stage.addChild(_createTower(towerCCenter));

    _reset();
  }

  void showNextMove() async {
    if (this._moves == null) {
      return;
    } else if (this._moves.isEmpty) {
      return;
    }

    List<int> move = this._moves.removeAt(0);

    Shape disk = towers[move[0]].removeLast();
    towers[move[1]].addLast(disk);

    if (move[1] == 0) {
      disk.x = towerACenter;
    }
    else if (move[1] == 1) {
      disk.x = towerBCenter;
    }
    else if (move[1] == 2) {
      disk.x = towerCCenter;
    }

    double diskHeight = (HEIGHT * .8) / this.numberOfDisks;

    disk.y = HEIGHT - diskHeight * (towers[move[1]].length-1) - (diskHeight / 2);

    this.steps++;
    
  }

  void onStartButtonPressed() {
    _reset();
  }

  void onShowNextMoveButtonPressed() {
    showNextMove();
  }

  void _reset() async {
    this._moves = null;
    this.steps = 0;

    for (int i = 0; i < 3; i++) {
      for (int k = 0; k < towers[i].length; k++) {
        this.stage.removeChild(towers[i].elementAt(k));
      }
      towers[i].clear();
    }

    _initDisks();

    this._moves = await solvers.getMovesRecursive(this.numberOfDisks);
  }

  void numberOfDisksChanged() {
    _reset();
  }

  void _initDisks() {
    double diskHeight = (HEIGHT * .8) / this.numberOfDisks;

    for (int i = 0; i < numberOfDisks; i++) {
      int size = numberOfDisks - i;
      int diskWidth = (MAX_DISK_WIDTH * (size / numberOfDisks)).toInt();

      Shape disk = new Shape()
        ..graphics.beginPath()
        ..graphics.rectRound(-diskWidth / 2, -diskHeight / 2, diskWidth, diskHeight, 10, 0)
        ..graphics.strokeColor(Color.Black, 1)
        ..graphics.fillColor(Color.BlanchedAlmond)
        ..graphics.closePath();

      disk.x = towerACenter;
      disk.y = HEIGHT - diskHeight * i - (diskHeight / 2);

      towers[0].addLast(disk);
      this.stage.addChild(disk);
    }
  }

  Shape _createTower(int center) {
    return new Shape()
      ..graphics.beginPath()
      ..graphics.rect(center - 20, HEIGHT * .2, 40, HEIGHT * .8)
      ..graphics.fillColor(Color.Brown)
      ..graphics.strokeColor(Color.Brown, 1)
      ..graphics.closePath();
  }
}