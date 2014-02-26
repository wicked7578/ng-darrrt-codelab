// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library s6_http.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';

import 'package:s6_http/src/pirate_module.dart';
import 'package:s6_http/src/badge_controller.dart';

main() {
  setUp(() {
   setUpInjector();
   module((Module m) => m.install(new PirateModule()));
  });
  tearDown(tearDownInjector);

  group('fetching data', () {
    Injector injector;
    MockHttpBackend backend;
    BadgeController badgeController;

    setUp((){
      inject((Injector _injector, MockHttpBackend _backend) {

        backend = _backend;
        injector = _injector;
        backend.expectGET('piratenames.json').respond('''{"names": [ "Anne"],
        "appellations": [ "Awesome"]}''');
      });
    });

    test('should fetch pirate names', async(() {

      expect(BadgeController.names, isEmpty);
      expect(BadgeController.appellations, isEmpty);

      badgeController = injector.get(BadgeController);
      expect(badgeController.dataLoaded, isFalse);
      expect(badgeController.pirateName, isEmpty);

      microLeap();
      backend.flush();
      microLeap();

      expect(BadgeController.names, ["Anne"]);
      expect(BadgeController.appellations, ["Awesome"]);
      expect(badgeController.dataLoaded, isTrue);
    }));

    test('should set the pirate name', async(() {
      badgeController = injector.get(BadgeController);
      badgeController.name ="Foo";
      expect(badgeController.pirateName, "Foo the Awesome");
    }));
  });
}
