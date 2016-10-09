part of client;

class DeviceMotionEventhandlingSystem extends VoidEntitySystem {
  TagManager tm;
  Mapper<DeviceMotion> dmm;
  Mapper<DeviceRotation> drm;

  Map<String, Map<String, dynamic>> motionData = {};
  Map<String, Map<String, double>> rotationData = {};

  WebSocket webSocket;

  DeviceMotionEventhandlingSystem(this.webSocket);

  @override
  void initialize() {
//    webSocket.onMessage.listen((event) {
//      print('message received ${event.data}');
//      var eventData = JSON.decode(event.data);
//      var id = '${eventData['id']}';
//      var content = eventData['content'];
//      if (null != content && content != 'removeClient') {
//        var contentMap = JSON.decode(content) as Map<String, dynamic>;
//        if (contentMap.containsKey('interval')) {
//          motionData[id] = contentMap;
//        } else if (contentMap.containsKey('alpha')) {
//          rotationData[id] = contentMap;
//        }
//      }
//    });
  }

  @override
  void processSystem() {
//    rotationData.forEach((key, value) {
//      var entity = tm.getEntity(key);
//      var dr = drm[entity];
//      dr.rot.setValues(
//          value['alpha'] ?? 0.0, value['beta'] ?? 0.0, value['gamma'] ?? 0.0);
//    });
    rotationData.clear();

    motionData.forEach((key, value) {
      var entity = tm.getEntity(key);
      var dm = dmm[entity];
      dm.acc.add(new Vector3(value['ax'] as double ?? 0.0,
          value['ay'] as double ?? 0.0, value['az'] as double ?? 0.0));
      dm.deltaRot.add(new Vector3(value['beta'] as double ?? 0.0,
          value['alpha'] as double ?? 0.0, value['gamma'] as double ?? 0.0));
      dm.interval += value['interval'] ?? 0;

    });
    motionData.clear();
  }

  @override
  bool checkProcessing() => motionData.isNotEmpty || rotationData.isNotEmpty;
}
