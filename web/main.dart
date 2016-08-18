// Copyright (c) 2016, Dennis Kaselow. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void main() {
  window.onDeviceOrientation.listen((event) {
    querySelector('#alpha').text = '${event.alpha}';
    querySelector('#beta').text = '${event.beta}';
    querySelector('#gamma').text = '${event.gamma}';
    querySelector('#absolute').text = '${event.absolute}';
  });

  window.onDeviceMotion.listen((event){
    var acc = event.acceleration;
    var accGrav = event.accelerationIncludingGravity;
    var rotationRate = event.rotationRate;
    var interval = event.interval;
    querySelector('#x').text = '${acc.x}, grav: ${accGrav.x}';
    querySelector('#y').text = '${acc.y}, grav: ${accGrav.y}';
    querySelector('#z').text = '${acc.z}, grav: ${accGrav.z}';
    querySelector('#rotalpha').text = '${rotationRate.alpha}';
    querySelector('#rotbeta').text = '${rotationRate.beta}';
    querySelector('#rotgamma').text = '${rotationRate.gamma}';
    querySelector('#interval').text = '${interval}';
  });

  window.on['compassneedscalibration'].listen((event) {
    querySelector('#info').text = 'Your compass needs calibrating! Wave your device in a figure-eight motion';
  });
}
