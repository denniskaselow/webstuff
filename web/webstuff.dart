import 'package:angular2/platform/browser.dart';

import 'package:webstuff/app_component.dart';
import 'package:webstuff/communication_service.dart';

void main() {

  bootstrap(AppComponent, [CommunicationService]);
}
