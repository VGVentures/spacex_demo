// ignore_for_file: prefer_const_constructors
import 'package:launch_repository/launch_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockSpaceXApiClient extends Mock implements SpaceXApiClient {}

void main() {
  group('LaunchRepository', () {
    late SpaceXApiClient spaceXApiClient;
    late LaunchRepository subject;

    final latestLaunch = Launch(
      id: '0',
      name: 'mock-launch-name',
      links: const Links(
        patch: Patch(
          small: 'https://avatars.githubusercontent.com/u/2918581?v=4',
          large: 'https://avatars.githubusercontent.com/u/2918581?v=4',
        ),
        webcast: 'https://www.youtube.com',
        wikipedia: 'https://www.wikipedia.org/',
      ),
    );

    setUp(() {
      spaceXApiClient = MockSpaceXApiClient();
      when(() => spaceXApiClient.fetchLatestLaunch())
          .thenAnswer((_) async => latestLaunch);

      subject = LaunchRepository(spaceXApiClient: spaceXApiClient);
    });

    test('constructor returns normally', () {
      expect(
        () => LaunchRepository(),
        returnsNormally,
      );
    });

    group('.fetchLatestLaunch', () {
      test('throws LaunchException when api throws an exception', () async {
        when(() => spaceXApiClient.fetchLatestLaunch()).thenThrow(Exception());

        expect(
          () => subject.fetchLatestLaunch(),
          throwsA(isA<LaunchException>()),
        );

        verify(() => spaceXApiClient.fetchLatestLaunch()).called(1);
      });

      test('makes correct request', () async {
        await subject.fetchLatestLaunch();

        verify(() => spaceXApiClient.fetchLatestLaunch()).called(1);
      });
    });

    test('makes correct request', () async {
      await subject.fetchLatestLaunch();

      verify(() => spaceXApiClient.fetchLatestLaunch()).called(1);
    });
  });
}
