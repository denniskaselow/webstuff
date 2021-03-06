library client;

import 'dart:convert';
import 'dart:html';
export 'dart:html';
import 'dart:web_gl';
import 'dart:typed_data';
import 'package:webstuff/communication_service.dart';
import 'package:webstuff/shared.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
export 'package:gamedev_helpers/gamedev_helpers.dart';
//part 'src/client/systems/name.dart';
part 'src/client/systems/events.dart';
part 'src/client/systems/rendering.dart';
part 'src/client/components.dart';

class Game extends GameBase {
  CommunicationService communicationService;

  Game(this.communicationService) : super.noAssets('webstuff', '#game', 200, 200, webgl: true) {
    world.addManager(new TagManager());
  }

  @override
  void createEntities() {
//    var e = addEntity([
//      new Position(0.0, 0.0, 0.0),
//      new DeviceRotation(0.0, 0.0, 0.0),
//      new DeviceMotion(0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
//    ]);
//
//    TagManager tm = world.getManager(TagManager);
//    tm.register(e, '0');
//    tm.register(e, '1');
//    tm.register(e, '2');
//    tm.register(e, '3');
  }

  @override
  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        new DeviceHandlerSystem(communicationService.allClientsSocket),
        new DeviceMotionEventhandlingSystem(communicationService.allClientsSocket),
        new DeviceWebGlCanvasCleaningSystem(),
        new MovementSystem(),
        new DevicePositionRenderingSystem(helper),
      ],
      GameBase.physics: [
        // add at least one
      ]
    };
  }

  Map<String, CanvasElement> get canvases => (world.getSystem(DeviceHandlerSystem) as DeviceHandlerSystem).canvases;

  void stopListeningToWebSockets() {
    (world.getSystem(DeviceHandlerSystem) as DeviceHandlerSystem).stopListening();
    (world.getSystem(DeviceMotionEventhandlingSystem) as DeviceMotionEventhandlingSystem).stopListening();
  }
}
