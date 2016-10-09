// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

@Component(
    selector: 'today',
    styleUrls: const ['../content.css'],
    templateUrl: 'today_component.html')
class TodayComponent implements OnInit {
  Random random = new Random();
  List<String> basicItems = [
    'Pseudo-elements',
    'Media Queries',
    'Flexible box layout (Flexbox)',
    'Canvas',
    'WebGL',
    'WebRTC',
    'Shadow DOM',
    'SIMD (Single instruction, multiple data)',
  ];

  List<String> items = [
    'Animations',
    'Background-image options',
    'Border images',
    'Border radius (rounded corners)',
    'Box shadows',
    'Box sizing',
    'Cascading and inheritance',
    'Colors',
    'Compositing and Blending',
    'Device Adaptation',
    'Downloadable fonts (@font-face)',
    'Exclusions',
    'Feature queries (@supports)',
    'Filter Effects',
    'Fixed positioning (position:fixed)',
    'Font-feature settings',
    'Font loading',
    'Gradients',
    'Grid layout',
    'Hyphenation',
    'Image Values and Replaced Content',
    'Logical properties',
    'Masking',
    'Motion paths',
    'Multiple-column layout',
    'Multiple backgrounds',
    'Opacity',
    'Overflow',
    'Pointer events',
    'Scroll Snap Points',
    'Selectors',
    'Shapes',
    'Sticky positioning (position:sticky)',
    'Text decoration',
    'Text overflow',
    'Text shadows',
    'Transforms (2D)',
    'Transforms (3D)',
    'Transitions',
    'Values and Units',
    'Will Change',
    'Writing modes',
    'CSSOM (CSS Object Model)',
    'CSSOM View Module',
    'SVG',
    'WOFF',
    'MathML',
    'Web Animations',
    'Web Audio API',
    'WebVTT',
    'Media Source Extensions',
    'Media Fragments',
    'Notifications API',
    'Cross-document messaging',
    'Channel messaging',
    'Fullscreen API',
    'Geofencing',
    'Geolocation',
    'Device Orientation',
    'Screen Orientation',
    'UI Events (formerly DOM Events)',
    'Pointer Events',
    'Touch Events',
    'Pointer Lock',
    'Gamepad',
    'getUserMedia',
    'Battery Status',
    'Vibration',
    'Beacon',
    'HTML Media Capture (the capture attribute)',
    'Clipboard API and events',
    'Storage (NavigatorStorage+StorageManager)',
    'Web Storage (localStorage)',
    'Indexed Database',
    'File API',
    'Blob URLs',
    'File Reader',
    'Object RTC (ORTC) API for WebRTC',
    'WebSocket protocol',
    'WebSocket API',
    'Server-Sent Events',
    'Push API',
    'Custom Elements',
    'Templates',
    'classList (DOMTokenList)',
    'dataset (data-* attributes)',
    'async for scripts',
    'defer for scripts',
    'Session-history management',
    'hashchange',
    'Sandboxed iframe',
    'Drag and drop',
    'contentEditable',
    'HTML Editing APIs',
    'ARIA',
    'Web Workers',
    'Shared Workers',
    'Timing control for script-based animations',
    'Navigation Timing',
    'Page Visibility',
    'User Timing',
    'Performance Timeline',
    'High Resolution Time',
    'Content Security Policy (CSP)',
    'Upgrade Insecure Requests',
    'Web Cryptography API',
    'Referrer policy',
    'Tracking Preference Expression (DNT)',
    'Structured cloning',
    'Transferable objects',
    'Mutation observers',
    'Streams',
    'DOM Parsing and Serialization',
    'DOM XPath',
    'Quirks Mode',
    'Internationalization API',
    'Promises',
    'JSON parsing',
    'Typed Array',
    'Service Workers',
    'querySelector() method',
    'matches() method',
    'matchMedia() method',
    'data URLs',
    'HTTP',
    'HTTP/2',
    'TLS',
    'Cookies',
    'Origin',
    'Unicode',
    'MIME Sniffing',
    'Web IDL',
    'Link header',
    'Content-Disposition header',
  ];

  List<Tech> techs = [];

  @override
  void ngOnInit() {
    showBasicItems().then((_){
      showAllItems();
    });
  }

  Future<Null> showBasicItems() {
    var completer = new Completer();
    var container = querySelector('ul#today');
    var index = 0;
    new Timer.periodic(new Duration(seconds: 1), (Timer timer) {
      var liElement = new LIElement();
      liElement.appendText(basicItems[index]);
      container.append(liElement);
      index++;
      if (index == basicItems.length) {
        timer.cancel();
        completer.complete();
      }
    });
    return completer.future;
  }

  void showAllItems() {
    items.shuffle();
    var duration = 1000;
    displayItem(duration);
  }

  void displayItem(int duration) {
    new Timer(new Duration(milliseconds: duration), () {
      techs.add(new Tech(items.removeLast(), {'left': '${random.nextInt(90)}%', 'top': '${random.nextInt(90)}%'}));
      if (items.isNotEmpty) {
        displayItem((duration * 0.95).toInt());
      }
    });
  }
}

class Tech {
  String name;
  Map<String, String> style;
  Tech(this.name, this.style);
}
