import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockSpaceXApiClient extends Mock implements SpaceXApiClient {}

void main() {
  group('RocketRepository', () {
    late SpaceXApiClient spaceXApiClient;
    late RocketRepository subject;

    final rockets = List.generate(
      3,
      (i) => Rocket(
        id: '$i',
        name: 'mock-rocket-name-$i',
        description: 'mock-rocket-description-$i',
        height: const Length(meters: 1, feet: 1),
        diameter: const Length(meters: 1, feet: 1),
        mass: const Mass(kg: 1, lb: 1),
        firstFlight: DateTime.now(),
      ),
    );

    setUp(() {
      spaceXApiClient = MockSpaceXApiClient();
      when(() => spaceXApiClient.fetchAllRockets())
          .thenAnswer((_) async => rockets);

      subject = RocketRepository(spaceXApiClient: spaceXApiClient);
    });

    test('constructor returns normally', () {
      expect(
        () => RocketRepository(),
        returnsNormally,
      );
    });

    group('.fetchAllRockets', () {
      test('throws RocketsException when api throws an exception', () async {
        when(() => spaceXApiClient.fetchAllRockets()).thenThrow(Exception());

        expect(
          () => subject.fetchAllRockets(),
          throwsA(isA<RocketsException>()),
        );

        verify(() => spaceXApiClient.fetchAllRockets()).called(1);
      });

      test('makes correct request', () async {
        await subject.fetchAllRockets();

        verify(() => spaceXApiClient.fetchAllRockets()).called(1);
      });
    });
  });
}
