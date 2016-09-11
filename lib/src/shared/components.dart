part of shared;

class Position extends Component {
  Vector3 pos;
  Position(double x, double y, double z) : pos = new Vector3(x, y, z);
}

class DeviceRotation extends Component {
  Vector3 rot;
  DeviceRotation(double alpha, double beta, double gamma)
      : rot = new Vector3(alpha, beta, gamma);
}

class DeviceMotion extends Component {
  num interval;
  Vector3 deltaRot;
  Vector3 acc;
  DeviceMotion(this.interval, double dAlpha, double dBeta, double dGamma,
      double ax, double ay, double az)
      : deltaRot = new Vector3(dAlpha, dBeta, dGamma),
        acc = new Vector3(ax, ay, az);
}
