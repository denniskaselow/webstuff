part of client;

class DeviceHandlerSystem extends VoidEntitySystem {
  TagManager tm;
  DevicePositionRenderingSystem dprs;

  WebSocket webSocket;
  StreamSubscription subscription;

  Set<String> unregistered = new Set<String>();
  Set<String> removeable = new Set<String>();
  Map<String, CanvasElement> canvases = <String, CanvasElement>{};
  DeviceHandlerSystem(this.webSocket);

  @override
  void initialize() {
    subscription = webSocket.onMessage.listen((event) {
      var eventData = JSON.decode(event.data);
      var id = '${eventData['id']}';
      var content = eventData['content'];
      if (content == 'removeClient') {
        removeable.add(id);
      }
      if (!tm.isRegistered(id)) {
        unregistered.add(id);
      }
    });
  }

  @override
  void processSystem() {
    unregistered.forEach((id) {
      var canvasElement = new CanvasElement(width: 200, height: 200);
      var e = world.createAndAddEntity([
        new Position(0.0, 0.0, 0.0),
        new DeviceRotation(0.0, 0.0, 0.0),
        new RenderTarget(canvasElement)
      ]);
      canvases[id] = canvasElement;
      tm.register(e, id);
    });
    unregistered.clear();

    removeable.forEach((id) {
      tm.getEntity(id).deleteFromWorld();
      canvases.remove(id);
    });

    world.processEntityChanges();
  }

  @override
  bool checkProcessing() =>
      (unregistered.isNotEmpty || removeable.isNotEmpty) &&
      dprs.shaderSource != null;

  void stopListening() {
    subscription.cancel();
  }
}

class DeviceMotionEventhandlingSystem extends VoidEntitySystem {
  TagManager tm;
  Mapper<DeviceMotion> dmm;
  Mapper<DeviceRotation> drm;

  Map<String, Map<String, double>> rotationData = {};

  WebSocket webSocket;
  StreamSubscription subscription;

  DeviceMotionEventhandlingSystem(this.webSocket);

  @override
  void initialize() {
    subscription = webSocket.onMessage.listen((event) {
      var eventData = JSON.decode(event.data);
      var id = '${eventData['id']}';
      var content = eventData['content'];
      if (null != content && content != 'removeClient') {
        var contentMap = JSON.decode(content) as Map<String, dynamic>;
        if (contentMap.containsKey('alpha')) {
          rotationData[id] = contentMap;
        }
      }
    });
  }

  @override
  void processSystem() {
    rotationData.forEach((key, value) {
      var entity = tm.getEntity(key);
      var dr = drm[entity];
      dr.rot.setValues(
          value['gamma'] == null ? 0.0 : -value['gamma'].toDouble(),
          value['beta'] == null ? 0.0 : value['beta'].toDouble(),
          value['alpha'] == null ? 0.0 : value['alpha'].toDouble());
    });
    rotationData.clear();
  }

  @override
  bool checkProcessing() => rotationData.isNotEmpty;

  void stopListening() {
    subscription.cancel();
  }
}
