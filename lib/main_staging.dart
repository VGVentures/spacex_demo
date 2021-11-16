import 'dart:async';
import 'dart:developer';

import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/app/app.dart';

void main() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final rocketRepository = RocketRepository();
  final crewMemberRepository = CrewMemberRepository();
  final launchRepository = LaunchRepository();

  runZonedGuarded(
    () => runApp(
      App(
        rocketRepository: rocketRepository,
        crewMemberRepository: crewMemberRepository,
        launchRepository: launchRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
