import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('SpaceXApiClient', () {
    late http.Client httpClient;
    late SpaceXApiClient subject;

    final rockets = List.generate(
      3,
      (i) => Rocket(
        id: '$i',
        name: 'mock-rocket-name-$i',
        description: 'mock-rocket-description-$i',
        height: const Length(meters: 1, feet: 1),
        diameter: const Length(meters: 1, feet: 1),
        mass: const Mass(kg: 1, lb: 1),
      ),
    );

    setUp(() {
      httpClient = MockHttpClient();

      subject = SpaceXApiClient(httpClient: httpClient);
    });

    setUpAll(() {
      registerFallbackValue<Uri>(Uri());
    });

    test('constructor returns normally', () {
      expect(
        () => SpaceXApiClient(),
        returnsNormally,
      );
    });

    group('.fetchAllRockets', () {
      setUp(() {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(json.encode(rockets), 200),
        );
      });

      test('throws HttpException when http client throws exception', () {
        when(() => httpClient.get(any())).thenThrow(Exception());

        expect(
          () => subject.fetchAllRockets(),
          throwsA(isA<HttpException>()),
        );
      });

      test(
        'throws HttpRequestFailure when response status code is not 200',
        () {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('', 400),
          );

          expect(
            () => subject.fetchAllRockets(),
            throwsA(
              isA<HttpRequestFailure>()
                  .having((error) => error.statusCode, 'statusCode', 400),
            ),
          );
        },
      );

      test(
        'throws JsonDecodeException when decoding response fails',
        () {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('definitely not json!', 200),
          );

          expect(
            () => subject.fetchAllRockets(),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );

      test(
        'throws JsonDeserializationException '
        'when deserializing json body fails',
        () {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response(
              '[{"this_is_not_a_rocket_doc": true}]',
              200,
            ),
          );

          expect(
            () => subject.fetchAllRockets(),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('makes correct request', () async {
        await subject.fetchAllRockets();

        verify(
          () => httpClient.get(
            Uri.https(SpaceXApiClient.authority, '/v4/rockets'),
          ),
        ).called(1);
      });

      test('returns correct list of rockets', () {
        expect(
          subject.fetchAllRockets(),
          completion(equals(rockets)),
        );
      });
    });
  });
}
