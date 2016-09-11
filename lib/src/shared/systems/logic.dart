part of shared;


class MovementSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  Mapper<DeviceRotation> drm;
  Mapper<DeviceMotion> dmm;

  MovementSystem() : super(Aspect.getAspectForAllOf([Position, DeviceRotation, DeviceMotion]));

  @override
  void processEntity(Entity entity) {
    var p = pm[entity];
    var dm = dmm[entity];
    var dr = drm[entity];
    var interval = dm.interval / 1000.0;
    p.pos += dm.acc * interval * interval / 1000.0;
    dr.rot += dm.deltaRot * interval;
    dm.acc.setZero();
    dm.deltaRot.setZero();
    dm.interval = 0.0;
  }
}