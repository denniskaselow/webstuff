part of shared;


class MovementSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  Mapper<DeviceMotion> dmm;

  MovementSystem() : super(Aspect.getAspectForAllOf([Position, DeviceMotion]));

  @override
  void processEntity(Entity entity) {
    var p = pm[entity];
    var dm = dmm[entity];
    var interval = dm.interval / 1000.0;
    p.pos += dm.acc * interval * interval / 1000.0;
    dm.acc.setZero();
  }
}