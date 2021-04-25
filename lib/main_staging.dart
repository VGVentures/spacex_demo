import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/app/app.dart';

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final rocketRepository = RocketRepository();

  runZonedGuarded(
    () => runApp(App(
      rocketRepository: rocketRepository,
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
