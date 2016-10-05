// Copyright (c) 2016, dennis. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:webstuff/client.dart' as dartemis;

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html')
class AppComponent implements OnInit {

  @override
  ngOnInit() {
    new dartemis.Game().start();
  }
}
