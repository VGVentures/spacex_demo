import 'dart:io';

import 'package:rocket_repository/rocket_repository.dart';

Future<void> main() async {
  final rocketRepository = RocketRepository();

  try {
    final rockets = await rocketRepository.fetchAllRockets();
    for (final rocket in rockets) {
      print(rocket);
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
