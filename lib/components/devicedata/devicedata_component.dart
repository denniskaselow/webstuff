// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:angular2/core.dart';
import 'package:webstuff/client.dart' as game;
import 'package:webstuff/communication_service.dart';

@Component(
    selector: 'devicedata',
    styleUrls: const ['devicedata_component.css', '../content.css'],
    templateUrl: 'devicedata_component.html')
class DevicedataComponent implements OnInit, DoCheck, OnDestroy {
  CommunicationService communicationService;
  @ViewChild("devices")
  ElementRef devices;
  game.Game canvasContainer;
  int canvasCount = 0;
  DevicedataComponent(this.communicationService);

  @override
  void ngOnInit() {
    communicationService.send('devicedata');
    new game.Game(this.communicationService).start().then((canvasContainer) {
      this.canvasContainer = canvasContainer;
    });
  }

  @override
  ngDoCheck() {
    if (canvasContainer != null) {
      var canvases = new Map.from(canvasContainer.canvases);
      if (canvasCount != canvases.length) {
        (devices.nativeElement as DivElement).innerHtml = '';
        canvases.values.forEach((canvas) {
          (devices.nativeElement as DivElement).append(canvas);
        });
        canvasCount = canvases.length;
      }
    }
  }
  @override
  ngOnDestroy() {
    communicationService.send('stopdevicedata');
    canvasContainer.stopListeningToWebSockets();
    canvasContainer.canvases.clear();
    canvasContainer.world.deleteAllEntities();
  }
}
