// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:webstuff/communication_service.dart';


@Component(
    selector: 'notifications',
    styleUrls: const ['notifications_component.css'],
    templateUrl: 'notifications_component.html')
class NotificationsComponent {
  CommunicationService communicationService;
  NotificationsComponent(this.communicationService);

  void send() {
    var text = (querySelector('#text') as InputElement).value;
    communicationService.send('notification', text);
  }
}
