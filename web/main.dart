// Copyright (c) 2016, Dennis Kaselow. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

main() async {

  var webSocket = new WebSocket('wss://isowosi.com/ws/s/webstuff');
  webSocket.onOpen.listen((_) {
    webSocket.onMessage.listen((event) {
      querySelector('#alpha').text = event.data;
    });
    webSocket.send('test1');
    webSocket.send('test2');
    webSocket.send('test3');
    webSocket.send('test4');

    window.onBeforeUnload.listen((event) {
      webSocket.send('cu');
      webSocket.close();
    });
  });
}
