library client;

import 'dart:html';
export 'dart:html';
import 'dart:web_gl';
import 'dart:typed_data';
import 'dart:convert';
import 'package:webstuff/shared.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
export 'package:gamedev_helpers/gamedev_helpers.dart';
//part 'src/client/systems/name.dart';
part 'src/client/systems/events.dart';
part 'src/client/systems/rendering.dart';

class Game extends GameBase {
  Game() : super.noAssets('webstuff', '#game', 200, 200, webgl: true) {
    world.addManager(new TagManager());
  }

  void createEntities() {
    var e = addEntity([
      new Position(0.0, 0.0, 0.0),
      new DeviceRotation(0.0, 0.0, 0.0),
      new DeviceMotion(0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    ]);

    var tm = world.getManager(TagManager) as TagManager;
    tm.register(e, '0');
    tm.register(e, '1');
    tm.register(e, '2');
    tm.register(e, '3');
  }

  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        new DeviceMotionEventhandlingSystem(),
        new WebGlCanvasCleaningSystem(ctx),
        new MovementSystem(),
        new DevicePositionRenderingSystem(this.ctx),
      ],
      GameBase.physics: [
        // add at least one
      ]
    };
  }
}
