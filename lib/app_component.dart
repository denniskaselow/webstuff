// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:webstuff/communication_service.dart';
import 'package:webstuff/client.dart' as dartemis;
import 'package:webstuff/components/intro/intro_component.dart';
import 'package:webstuff/components/notifications/notifications_component.dart';
import 'package:webstuff/components/webrtc/webrtc_component.dart';
import 'package:webstuff/components/websockets/websockets_component.dart';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [
      IntroComponent,
      WebsocketsComponent,
      WebRtcComponent,
      NotificationsComponent
    ])
class AppComponent implements OnInit {
  int page = 0;
  List<String> pages = ['Agenda', 'WebSockets', 'WebRTC', 'Notifications'];
  CommunicationService communicationService;

  AppComponent(this.communicationService);

  @override
  ngOnInit() {
    new dartemis.Game(this.communicationService).start();
  }

  void next() {
    page++;
  }

  void previous() {
    page--;
  }

  String get clients => communicationService.clients;
}
