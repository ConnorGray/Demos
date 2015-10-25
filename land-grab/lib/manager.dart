part of land_grab;

abstract class Manager extends DisplayObjectContainer {
  LandGrab _landGrab;

  Manager(this._landGrab);

  void clean();
}
