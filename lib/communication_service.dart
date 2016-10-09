import 'dart:convert';
import 'dart:html';

import 'package:angular2/core.dart';

@Injectable()
class CommunicationService {
  WebSocket allClientsSocket;
  WebSocket bcSocket;
  String clients = '0';
  List<ChatMessage> chatMessages = [];

  CommunicationService() {
    allClientsSocket = new WebSocket('wss://isowosi.com/ws/s/webstuff');
    bcSocket = new WebSocket('wss://isowosi.com/ws/bc/webstuff');

    allClientsSocket.onMessage.listen((event) {
      Map data = JSON.decode(event.data);
      try {
        if (data['type'] == 'clientCount') {
          clients = data['message'];
        }
      } catch (_) {}
    });
    bcSocket.onMessage.listen((event) {
      Map data = JSON.decode(event.data);
      try {
        if (data.containsKey('content') && data['content'] != 'removeClient') {
          Map payload = JSON.decode(data['content']);
          if (payload['type'] == 'chat') {
            chatMessages
                .add(new ChatMessage('${data['id']}', payload['content'], new DateTime.now()));
            print(chatMessages);
          }
        }
      } catch (_) {}
    });
  }

  void send(String type, String content) {
    allClientsSocket.send(JSON.encode({'type': type, 'content': content}));
  }

  void chat(String content) {
    bcSocket.send(JSON.encode({'type': 'chat', 'content': content}));
    chatMessages.add(new ChatMessage('Ich', content, new DateTime.now()));
  }
}

class ChatMessage {
  String id;
  String text;
  DateTime timestamp;
  ChatMessage(this.id, this.text, this.timestamp);
}
