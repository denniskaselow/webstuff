import 'dart:convert';
import 'dart:html';

import 'package:angular2/core.dart';


@Injectable()
class CommunicationService {

  WebSocket allClientsSocket;
  WebSocket bcSocket;

  CommunicationService() {
    allClientsSocket = new WebSocket('wss://isowosi.com/ws/s/webstuff');
    bcSocket = new WebSocket('wss://isowosi.com/ws/bc/webstuff');
  }

  void send(String type, String content) {
    allClientsSocket.send(JSON.encode({'type': type, 'content': content}));
  }
}