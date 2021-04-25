import 'dart:io';

import 'package:spacex_api/spacex_api.dart';

void main() async {
  final spaceXApiClient = SpaceXApiClient();

  try {
    final rockets = await spaceXApiClient.fetchAllRockets();
    for (final rocket in rockets) {
      print(rocket);
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
