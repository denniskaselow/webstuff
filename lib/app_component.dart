// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:webstuff/communication_service.dart';
import 'package:webstuff/components/agenda/agenda_component.dart';
import 'package:webstuff/components/chat/chat_component.dart';
import 'package:webstuff/components/devicedata/devicedata_component.dart';
import 'package:webstuff/components/history/history_component.dart';
import 'package:webstuff/components/intro/intro_component.dart';
import 'package:webstuff/components/notifications/notifications_component.dart';
import 'package:webstuff/components/today/today_component.dart';
import 'package:webstuff/components/websockets/websockets_component.dart';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [
      IntroComponent,
      AgendaComponent,
      HistoryComponent,
      TodayComponent,
      WebsocketsComponent,
      NotificationsComponent,
      ChatComponent,
      DevicedataComponent
    ])
class AppComponent {
  int page = 0;
  List<String> pages = [
    'Möglichkeiten des Web',
    'Agenda',
    'Geschichte des Web',
    'Das Web heute',
    'Raus mit den Smartphones',
    'Notifications',
    'Chat',
    'Tracking',
    'Fragen?'
  ];
  CommunicationService communicationService;

  AppComponent(this.communicationService);

  void next() {
    page++;
  }

  void previous() {
    page--;
  }

  String get clients => communicationService.clients;
}
