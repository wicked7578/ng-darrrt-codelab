// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library s6_http.main;

import 'package:angular/angular.dart';
import 'package:s6_http/src/pirate_module.dart';

void main() {
  ngBootstrap(module: new PirateModule());
}
