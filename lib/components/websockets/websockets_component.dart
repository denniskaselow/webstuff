// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:math';

import 'package:angular2/core.dart';
import 'package:webstuff/communication_service.dart';

@Component(
    selector: 'websockets',
    styleUrls: const ['../content.css'],
    templateUrl: 'websockets_component.html')
class WebsocketsComponent {
  CommunicationService communicationService;
  int changes = 1;

  WebsocketsComponent(this.communicationService);

  void changeColor() {
    var random = new Random();
    communicationService.send(
        'changeColor',
        JSON.encode({
          'h': random.nextInt(360),
          's': random.nextInt(100),
          'l': random.nextInt(100)
        }));
    changes++;
  }

  void resetColor() {
    communicationService.send(
        'changeColor',
        JSON.encode({
          'h': 0,
          's': 0,
          'l': 100
        }));
  }
}
