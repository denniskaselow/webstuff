// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:webstuff/communication_service.dart';

@Component(
    selector: 'chat',
    styleUrls: const ['../content.css'],
    styles: const ['''
.chatmessage {
  font-size: 25px;
  border-bottom: 1px solid black;
  margin-left: 30px;
}
input {
  margin-left: 30px;
  width: 50%;
}
    '''],
    templateUrl: 'chat_component.html')
class ChatComponent implements OnInit {
  CommunicationService communicationService;

  ChatComponent(this.communicationService);

  @override
  ngOnInit() {
    communicationService.send('chat', '');
  }

  void send(String value) {
    if (value.isNotEmpty) {
      communicationService.chat(value);
    }
  }

  List<ChatMessage> get messages => communicationService.chatMessages;
}
