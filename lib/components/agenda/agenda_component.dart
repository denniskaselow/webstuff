// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
    selector: 'agenda',
    styleUrls: const ['../content.css'],
    templateUrl: 'agenda_component.html')
class AgendaComponent {
  @Input()
  List<String> items;
}
