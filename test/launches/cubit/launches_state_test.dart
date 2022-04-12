// ignore_for_file: cascade_invocations
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/launches/launches.dart';

void main() {
  group('LaunchesState', () {
    final date = DateTime.now();
    final launch = Launch(
      id: '0',
      name: 'mock-launch-name',
      dateLocal: date,
      dateUtc: date,
      links: const Links(
        patch: Patch(
          small: 'https://avatars.githubusercontent.com/u/2918581?v=4',
          large: 'https://avatars.githubusercontent.com/u/2918581?v=4',
        ),
        webcast: 'https://www.youtube.com',
        wikipedia: 'https://www.wikipedia.org/',
      ),
    );
    test('supports value comparison', () {
      expect(
        LaunchesState(
          status: LaunchesStatus.success,
          latestLaunch: launch,
        ),
        LaunchesState(
          status: LaunchesStatus.success,
          latestLaunch: launch,
        ),
      );
    });
  });
}
