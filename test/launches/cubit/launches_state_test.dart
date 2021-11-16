import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/launches/cubit/launches_cubit.dart';

void main() {
  group('CrewState', () {
    test('supports value comparison', () {
      expect(
        const LaunchesState(
          status: LaunchesStatus.success,
          latestLaunch: Launch(
            id: '0',
            name: 'mock-launch-name',
            links: Links(
              patch: Patch(
                small: 'https://avatars.githubusercontent.com/u/2918581?v=4',
                large: 'https://avatars.githubusercontent.com/u/2918581?v=4',
              ),
              webcast: 'https://www.youtube.com',
              wikipedia: 'https://www.wikipedia.org/',
            ),
          ),
        ),
        const LaunchesState(
          status: LaunchesStatus.success,
          latestLaunch: Launch(
            id: '0',
            name: 'mock-launch-name',
            links: Links(
              patch: Patch(
                small: 'https://avatars.githubusercontent.com/u/2918581?v=4',
                large: 'https://avatars.githubusercontent.com/u/2918581?v=4',
              ),
              webcast: 'https://www.youtube.com',
              wikipedia: 'https://www.wikipedia.org/',
            ),
          ),
        ),
      );
    });
  });
}