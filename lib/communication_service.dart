import 'dart:convert';
import 'dart:html';

import 'package:angular2/core.dart';


@Injectable()
class CommunicationService {

  WebSocket allClientsSocket;
  WebSocket bcSocket;
  String clients = '0';

  CommunicationService() {
    allClientsSocket = new WebSocket('wss://isowosi.com/ws/s/webstuff');
    bcSocket = new WebSocket('wss://isowosi.com/ws/bc/webstuff');

    allClientsSocket.onMessage.listen((event) {
      print('all ${event.data}');
      var data = JSON.decode(event.data) as Map;
      try {
        if (data['type'] == 'clientCount') {
          clients = data['message'];
        }
      } catch (_) {}
    });
  }

  void send(String type, String content) {
    allClientsSocket.send(JSON.encode({'type': type, 'content': content}));
  }
}