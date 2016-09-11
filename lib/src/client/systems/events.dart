part of client;

class DeviceMotionEventhandlingSystem extends VoidEntitySystem {
  TagManager tm;
  Mapper<DeviceMotion> dmm;

  Map<String, Map<String, dynamic>> data = {};

  @override
  void initialize() {
    var webSocket = new WebSocket('wss://isowosi.com/ws/s/webstuff');
    webSocket.onMessage.listen((event) {
      var eventData = JSON.decode(event.data);
      var id = '${eventData['id']}';
      var content = eventData['content'];
      if (null != content) {
        var contentMap = JSON.decode(content) as Map<String, dynamic>;
        if (contentMap.containsKey('interval')) {
          data[id] = contentMap;
        }
      }
    });
  }

  @override
  void processSystem() {
    data.forEach((key, value) {
      var entity = tm.getEntity(key);
      var dm = dmm[entity];
      dm.acc.add(new Vector3(value['ax'] as double ?? 0.0,
          value['ay'] as double ?? 0.0, value['az'] as double ?? 0.0));
      dm.deltaRot.add(new Vector3(value['alpha'] as double ?? 0.0,
          value['beta'] as double ?? 0.0, value['gamma'] as double ?? 0.0));
      dm.interval += value['interval'] ?? 0;
    });
    data.clear();
  }

  @override
  bool checkProcessing() => data.isNotEmpty;
}
