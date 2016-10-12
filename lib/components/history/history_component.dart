// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

@Component(
    selector: 'history',
    styleUrls: const ['../content.css'],
    templateUrl: 'history_component.html')
class HistoryComponent implements OnInit {
  List<String> itemsIntro = [
    '1989 - HTML',
    '1994 - CSS',
    '1996 - Javascript/JScript',
    '1997 - ECMAScript',
    '1998-2005 - the xml http thing/AJAX',
    '2009 - ECMAScript 5',
    '2011 - HTML5'
  ];

  @override
  void ngOnInit() {
    var container = querySelector('ul#history');
    var index = 1;
    var liElement = new LIElement();
    liElement.appendText(itemsIntro[0]);
    container.append(liElement);
    new Timer.periodic(new Duration(seconds: 10), (Timer timer) {
      var liElement = new LIElement();
      liElement.appendText(itemsIntro[index]);
      container.append(liElement);
      index++;
      if (index == itemsIntro.length) {
        timer.cancel();
      }
    });
  }
}
